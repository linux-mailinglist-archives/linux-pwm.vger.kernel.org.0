Return-Path: <linux-pwm+bounces-9681-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pgkGJ4ctUGq7ugIAu9opvQ
	(envelope-from <linux-pwm+bounces-9681-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 01:23:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B97363AF
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 01:23:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=maslowski.xyz header.s=mail header.b=FzT9y8Xb;
	dmarc=pass (policy=reject) header.from=maslowski.xyz;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9681-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9681-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F72301829E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB83AB292;
	Thu,  9 Jul 2026 23:23:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.maslowski.xyz (mail.maslowski.xyz [45.77.158.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DEE347BAF;
	Thu,  9 Jul 2026 23:23:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639429; cv=none; b=Tn0CxMf4y6h/9EB8HQ9iDO7nItUJMx5JnSGqSPZlhIkoqpK856/yOA7EptmoW9omrS0pnnLqtownMSZ8w8uxO6GuNITZThpTfAHxfdVzTBX4A8bGBGfFMk6T701oDeTc7k7DWw82feL3LYexFfV4ypa27qmHmo6EIKK8cUrUk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639429; c=relaxed/simple;
	bh=6p4mTHct6xG4EjksULhZhC0FBM6s3IkWFA5OdscgQ9g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OoQFoCd0EjA4SzV6mBSoxzgGD+yvBylQy28tGzCLngQnq8teQiH77KPfZ76S4iF0H6T0N5AvE3SCOR6iDy+hx9pVeXctzeTGc3/oLomg03BNfwxKwrWjGk9KieJyqbMugFzkxWsPi76pTOSPkvj+9r+rdVedPUWhJG7TbJZWRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maslowski.xyz; spf=pass smtp.mailfrom=maslowski.xyz; dkim=pass (2048-bit key) header.d=maslowski.xyz header.i=@maslowski.xyz header.b=FzT9y8Xb; arc=none smtp.client-ip=45.77.158.94
Received: from localhost (public-gprs387849.centertel.pl [37.47.146.74])
	by mail.maslowski.xyz (Postfix) with ESMTPSA id EB0CE7D5AC;
	Thu,  9 Jul 2026 23:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=maslowski.xyz;
	s=mail; t=1783639063;
	bh=6p4mTHct6xG4EjksULhZhC0FBM6s3IkWFA5OdscgQ9g=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=FzT9y8Xb8ZNgiWivEhcuM9ax/2mZEvdYBOIH9b3rFWRnv+oUTd3enuolQPLD7SKOq
	 hRTkLGZtoXjWkqAB8SwxF51ELLrVeAJWbycZ2TxTnHyGBf3I4J26pqjITfSQwXXblc
	 7OyjEgrjZ0dTD2rOMo1ncmD1z3KiP/Q8yDuUv2o8/bVhRFjtcZYb0/Yu4EadKso4Tj
	 BlBZH9/wr1tt6PGKIkNac2nB7j9vzkaiEYtSJttq1Vlpf4S4+SMPZ+9Ps/mqHJfEO+
	 MAsSfXywvllxKToDmvCYNk4kr3PzsrUnGhoK0Rqo1rJssb78m7yhYLw/irtxpvdesY
	 IHgcA1OmICZrQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 01:17:39 +0200
Message-Id: <DJUFA03SIN5C.1A8B6N89448P0@maslowski.xyz>
To: "Janne Grunau" <j@jannau.net>
Cc: "Sven Peter" <sven@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, "Linus Walleij" <linusw@kernel.org>, "Mark Kettenis"
 <kettenis@openbsd.org>, "Andi Shyti" <andi.shyti@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Sasha
 Finkelstein" <k@chaosmail.tech>, <asahi@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 08/11] dt-bindings: i2c: apple,i2c: Add t6030 and t6031
 compatibles
From: =?utf-8?q?Piotr_Mas=C5=82owski?= <piotr@maslowski.xyz>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net> <20260709-apple-t603x-initial-devices-v1-8-55b305833123@jannau.net>
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-8-55b305833123@jannau.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[maslowski.xyz,reject];
	R_DKIM_ALLOW(-0.20)[maslowski.xyz:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:j@jannau.net,m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9681-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[piotr@maslowski.xyz,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr@maslowski.xyz,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[maslowski.xyz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,maslowski.xyz:from_mime,maslowski.xyz:dkim,maslowski.xyz:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E90B97363AF

Hello. This is the tiniest possible nitpick, but it could
throw somebody off when grepping through commit messages so:

On Thu Jul 9, 2026 at 9:30 AM CEST, Janne Grunau wrote:
> The i2c block on Apple silicon M3 Pro, Max and Ultra SoCs are compatible
> with the t8103 (M1) one. Add "apple,t6030-i2c" for M3 Pro and
> "apple,t6031-i2c" for M3 Max and Ultra as per-S0C compatibles.

You've got a '0' (zero) instead of an 'O' here.  ^

>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Docum=
entation/devicetree/bindings/i2c/apple,i2c.yaml
> index 9e59200ad37b..d39f5e3f1df4 100644
> --- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
> @@ -24,6 +24,8 @@ properties:
>        - items:
>            - enum:
>                - apple,t6020-i2c
> +              - apple,t6030-i2c
> +              - apple,t6031-i2c
>                - apple,t8122-i2c
>            - const: apple,t8103-i2c
>        - items:

Cheers,
Piotr Mas=C5=82owski

