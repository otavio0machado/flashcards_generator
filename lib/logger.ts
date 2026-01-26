/**
 * Logger Estruturado
 *
 * Fornece logging consistente em todo o codebase com níveis,
 * prefixos e timestamps padronizados.
 */

type LogLevel = 'debug' | 'info' | 'warn' | 'error';

interface LogContext {
    [key: string]: unknown;
}

interface LogEntry {
    timestamp: string;
    level: LogLevel;
    module: string;
    message: string;
    context?: LogContext;
    error?: {
        name: string;
        message: string;
        stack?: string;
    };
}

const LOG_LEVELS: Record<LogLevel, number> = {
    debug: 0,
    info: 1,
    warn: 2,
    error: 3,
};

function getMinLogLevel(): LogLevel {
    const envLevel = process.env.LOG_LEVEL?.toLowerCase() as LogLevel | undefined;
    if (envLevel && envLevel in LOG_LEVELS) {
        return envLevel;
    }
    return process.env.NODE_ENV === 'production' ? 'info' : 'debug';
}

function shouldLog(level: LogLevel): boolean {
    const minLevel = getMinLogLevel();
    return LOG_LEVELS[level] >= LOG_LEVELS[minLevel];
}

function formatError(error: unknown): LogEntry['error'] | undefined {
    if (error instanceof Error) {
        return {
            name: error.name,
            message: error.message,
            stack: error.stack,
        };
    }
    if (error) {
        return {
            name: 'UnknownError',
            message: String(error),
        };
    }
    return undefined;
}

function createLogEntry(
    level: LogLevel,
    module: string,
    message: string,
    context?: LogContext,
    error?: unknown
): LogEntry {
    const entry: LogEntry = {
        timestamp: new Date().toISOString(),
        level,
        module,
        message,
    };

    if (context && Object.keys(context).length > 0) {
        entry.context = context;
    }

    if (error) {
        entry.error = formatError(error);
    }

    return entry;
}

function logToConsole(entry: LogEntry): void {
    const prefix = `[${entry.timestamp}] [${entry.level.toUpperCase()}] [${entry.module}]`;
    const message = `${prefix} ${entry.message}`;

    switch (entry.level) {
        case 'debug':
            console.debug(message, entry.context || '');
            break;
        case 'info':
            console.info(message, entry.context || '');
            break;
        case 'warn':
            console.warn(message, entry.context || '');
            break;
        case 'error':
            console.error(message, entry.context || '', entry.error || '');
            break;
    }
}

/**
 * Cria um logger para um módulo específico
 */
export function createLogger(module: string) {
    return {
        debug(message: string, context?: LogContext) {
            if (shouldLog('debug')) {
                logToConsole(createLogEntry('debug', module, message, context));
            }
        },

        info(message: string, context?: LogContext) {
            if (shouldLog('info')) {
                logToConsole(createLogEntry('info', module, message, context));
            }
        },

        warn(message: string, context?: LogContext) {
            if (shouldLog('warn')) {
                logToConsole(createLogEntry('warn', module, message, context));
            }
        },

        error(message: string, error?: unknown, context?: LogContext) {
            if (shouldLog('error')) {
                logToConsole(createLogEntry('error', module, message, context, error));
            }
        },
    };
}

// Logger padrão para uso geral
export const logger = createLogger('App');

// Loggers pré-configurados para módulos comuns
export const apiLogger = createLogger('API');
export const authLogger = createLogger('Auth');
export const dbLogger = createLogger('Database');
export const aiLogger = createLogger('AI');
export const imageLogger = createLogger('Image');
export const stripeLogger = createLogger('Stripe');
