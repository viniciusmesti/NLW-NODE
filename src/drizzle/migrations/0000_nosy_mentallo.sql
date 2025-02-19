CREATE TABLE "subscription" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"email" text NOT NULL,
	"creted_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "subscription_email_unique" UNIQUE("email")
);
