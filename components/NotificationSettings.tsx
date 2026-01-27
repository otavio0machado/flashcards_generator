'use client';

import { useState, useEffect } from 'react';
import { Bell, BellOff, Loader2, CheckCircle, AlertCircle } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { trackEvent } from '@/lib/analytics';

type PermissionState = 'default' | 'granted' | 'denied';

export default function NotificationSettings() {
    const [permission, setPermission] = useState<PermissionState>('default');
    const [isSubscribed, setIsSubscribed] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [success, setSuccess] = useState<string | null>(null);
    const [reminderHour, setReminderHour] = useState(19); // Default 7 PM
    const [isSupported, setIsSupported] = useState(true);

    useEffect(() => {
        // Check if push notifications are supported
        if (!('Notification' in window) || !('serviceWorker' in navigator) || !('PushManager' in window)) {
            setIsSupported(false);
            return;
        }

        setPermission(Notification.permission as PermissionState);

        // Check existing subscription
        checkSubscription();
    }, []);

    async function checkSubscription() {
        try {
            const registration = await navigator.serviceWorker.ready;
            const subscription = await registration.pushManager.getSubscription();
            setIsSubscribed(!!subscription);
        } catch {
            console.error('Error checking subscription');
        }
    }

    async function subscribeUser() {
        setIsLoading(true);
        setError(null);
        setSuccess(null);

        try {
            // Request notification permission
            const permissionResult = await Notification.requestPermission();
            setPermission(permissionResult as PermissionState);

            if (permissionResult !== 'granted') {
                setError('Permissão para notificações foi negada');
                trackEvent('notification_permission_denied');
                return;
            }

            // Get VAPID public key from server
            const keyResponse = await fetch('/api/push/subscribe');
            const { publicKey } = await keyResponse.json();

            if (!publicKey) {
                setError('Servidor não configurado para notificações push');
                return;
            }

            // Get service worker registration
            const registration = await navigator.serviceWorker.ready;

            // Subscribe to push
            const subscription = await registration.pushManager.subscribe({
                userVisibleOnly: true,
                applicationServerKey: urlBase64ToUint8Array(publicKey)
            });

            // Save subscription to server
            const response = await fetch('/api/push/subscribe', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    subscription: subscription.toJSON(),
                    action: 'subscribe'
                })
            });

            if (!response.ok) {
                throw new Error('Failed to save subscription');
            }

            setIsSubscribed(true);
            setSuccess('Notificações ativadas com sucesso!');
            trackEvent('push_notifications_enabled');
        } catch (err) {
            console.error('Error subscribing:', err);
            setError('Falha ao ativar notificações. Tente novamente.');
        } finally {
            setIsLoading(false);
        }
    }

    async function unsubscribeUser() {
        setIsLoading(true);
        setError(null);
        setSuccess(null);

        try {
            const registration = await navigator.serviceWorker.ready;
            const subscription = await registration.pushManager.getSubscription();

            if (subscription) {
                await subscription.unsubscribe();
            }

            // Remove from server
            await fetch('/api/push/subscribe', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ action: 'unsubscribe' })
            });

            setIsSubscribed(false);
            setSuccess('Notificações desativadas');
            trackEvent('push_notifications_disabled');
        } catch (err) {
            console.error('Error unsubscribing:', err);
            setError('Falha ao desativar notificações');
        } finally {
            setIsLoading(false);
        }
    }

    async function updateReminderTime(hour: number) {
        setReminderHour(hour);
        try {
            const response = await fetch('/api/settings/notifications', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ reminderHour: hour })
            });
            if (response.ok) {
                setSuccess('Horário do lembrete atualizado!');
                setTimeout(() => setSuccess(null), 3000);
            }
        } catch {
            setError('Falha ao salvar configuração');
        }
    }

    if (!isSupported) {
        return (
            <div className="rounded-lg border border-zinc-200 bg-zinc-50 p-4 dark:border-zinc-700 dark:bg-zinc-800/50">
                <div className="flex items-center gap-3 text-zinc-500 dark:text-zinc-400">
                    <BellOff className="h-5 w-5" />
                    <div>
                        <p className="font-medium">Notificações não suportadas</p>
                        <p className="text-sm">Seu navegador não suporta notificações push.</p>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="space-y-4">
            <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                    <div className={`rounded-full p-2 ${
                        isSubscribed 
                            ? 'bg-brand/10 text-brand' 
                            : 'bg-zinc-100 text-zinc-500 dark:bg-zinc-800 dark:text-zinc-400'
                    }`}>
                        {isSubscribed ? <Bell className="h-5 w-5" /> : <BellOff className="h-5 w-5" />}
                    </div>
                    <div>
                        <h3 className="font-medium text-zinc-900 dark:text-zinc-100">
                            Lembretes de Estudo
                        </h3>
                        <p className="text-sm text-zinc-500 dark:text-zinc-400">
                            Receba lembretes diários para manter sua sequência
                        </p>
                    </div>
                </div>

                <button
                    onClick={isSubscribed ? unsubscribeUser : subscribeUser}
                    disabled={isLoading || permission === 'denied'}
                    className={`flex items-center gap-2 rounded-lg px-4 py-2 text-sm font-medium transition-colors ${
                        isSubscribed
                            ? 'bg-zinc-100 text-zinc-700 hover:bg-zinc-200 dark:bg-zinc-800 dark:text-zinc-300 dark:hover:bg-zinc-700'
                            : 'bg-brand text-white hover:bg-brand/90'
                    } disabled:cursor-not-allowed disabled:opacity-50`}
                >
                    {isLoading ? (
                        <Loader2 className="h-4 w-4 animate-spin" />
                    ) : isSubscribed ? (
                        'Desativar'
                    ) : (
                        'Ativar'
                    )}
                </button>
            </div>

            {permission === 'denied' && (
                <div className="flex items-center gap-2 rounded-lg bg-red-50 p-3 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">
                    <AlertCircle className="h-4 w-4 flex-shrink-0" />
                    <p>
                        Notificações bloqueadas. Altere nas configurações do navegador para ativar.
                    </p>
                </div>
            )}

            <AnimatePresence>
                {error && (
                    <motion.div
                        initial={{ opacity: 0, y: -10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0 }}
                        className="flex items-center gap-2 rounded-lg bg-red-50 p-3 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400"
                    >
                        <AlertCircle className="h-4 w-4 flex-shrink-0" />
                        <p>{error}</p>
                    </motion.div>
                )}
                {success && (
                    <motion.div
                        initial={{ opacity: 0, y: -10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0 }}
                        className="flex items-center gap-2 rounded-lg bg-green-50 p-3 text-sm text-green-600 dark:bg-green-900/20 dark:text-green-400"
                    >
                        <CheckCircle className="h-4 w-4 flex-shrink-0" />
                        <p>{success}</p>
                    </motion.div>
                )}
            </AnimatePresence>

            {isSubscribed && (
                <motion.div
                    initial={{ opacity: 0, height: 0 }}
                    animate={{ opacity: 1, height: 'auto' }}
                    className="border-t border-zinc-200 pt-4 dark:border-zinc-700"
                >
                    <label className="block text-sm font-medium text-zinc-700 dark:text-zinc-300 mb-2">
                        Horário do lembrete
                    </label>
                    <select
                        value={reminderHour}
                        onChange={(e) => updateReminderTime(Number(e.target.value))}
                        className="w-full max-w-xs rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm focus:border-brand focus:outline-none focus:ring-1 focus:ring-brand dark:border-zinc-600 dark:bg-zinc-800 dark:text-white"
                    >
                        {Array.from({ length: 24 }, (_, i) => (
                            <option key={i} value={i}>
                                {String(i).padStart(2, '0')}:00
                            </option>
                        ))}
                    </select>
                    <p className="mt-1 text-xs text-zinc-500 dark:text-zinc-400">
                        Você receberá um lembrete se não tiver estudado até esse horário
                    </p>
                </motion.div>
            )}
        </div>
    );
}

// Helper function to convert VAPID key
function urlBase64ToUint8Array(base64String: string): ArrayBuffer {
    const padding = '='.repeat((4 - (base64String.length % 4)) % 4);
    const base64 = (base64String + padding)
        .replace(/-/g, '+')
        .replace(/_/g, '/');

    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
        outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray.buffer as ArrayBuffer;
}
