Return-Path: <linux-pwm+bounces-8863-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNZlCWrkAWoEmAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8863-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 16:15:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF650FDD8
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36BBA30A9413
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2523FB7F3;
	Mon, 11 May 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKTeSWEX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758663E63B8
	for <linux-pwm@vger.kernel.org>; Mon, 11 May 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508400; cv=none; b=aa6YVp8qK9LdekO62h0B6VaoqiSlvckzNVvpMbbmRYHeho10ulODu0VjiBMWIFIP5IbsNWJNu9v2U6HhKqx1a+Bghzj4p6rCpHmvf2bVCHXOuTHq+1MuJ9fEdo42g+m7yawkfQEwoCBfGMGvrn4g+D+66IE0ISnKtxIr2IzSZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508400; c=relaxed/simple;
	bh=7cxxZqN1g0qqNRtwUJmzJW5yzCgloqX4VcBEh/hoaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPUyL0o/wovkZLKAn8dt+8xT7099WTEe/zZHEaDZcpiKTJEt41cvjKk/Fk5exR0EUcWK8kKdBkh6eLfd/gZTg1B9NSmQkPa1Kiz/rjK31W1PY0aywka6XMbtVPlEqh9zKyQwNcHhMByZJ4CjZUQkPe0xoLDHGeUHDAZlJhemQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKTeSWEX; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1329fc4bf77so3935134c88.1
        for <linux-pwm@vger.kernel.org>; Mon, 11 May 2026 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508398; x=1779113198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH/da57m9j66BBfxDcaOUHxrZwIbeRL1xLwNB3IDa6M=;
        b=SKTeSWEXI8xOklgjnsdTA4FFc2Az5uuSySfJDxW04LK2RR3bE3c21CmWqwjvb5EV11
         JA37LMcgHcqYdELPPjVvbCEihWiqu15VyeIYRcbal0WDusDny+wmV9qfH32mPCjcxOP1
         dBjbVyy5TKkbZoXdaX3AM6sUxoqkDo5NUoUdKZxDMUUBBMKVpoTvUz3dTboUz1fK9bT3
         ChpNeT60APhX8purJCLB+GCdI6hZJ21/UhQyRjeWt1+QajJXVdM217cGyAbGvcGb2bzd
         hlk7qcH1btT7rnMgYol8S/muWhsX/kdSxcL6vo3Duc4cnqkiO2919d3WIyJh89HYmF72
         aRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508398; x=1779113198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yH/da57m9j66BBfxDcaOUHxrZwIbeRL1xLwNB3IDa6M=;
        b=E2SYXG4oKsNXjP8mQyxyR/uiJJXJU8ZW1HQ3nsl4WA1mpVLZ0KdtHs61TSbDCKTEzk
         caAtmHGWwqzF+jHFPa8nwy1zmCSHHd50N7MPi30dwzlVmYAC9omHgxeNSJ0oemehD0Zl
         HqPT3ugYVTRVAvnvtbnqLYjEuikuvicTvwSADHj/4lGDZkI0Y9/nFtrfw1RFmFsAu7Hz
         aHKLWDrID118xtKFJC1qhm8pTwOUpOi/MH6N3dHQPMyAt0Xx9SU1NmOUeH63EpUAtnGo
         zBS0A5VuxyDLEEYvLLU3lUlOc1HS2g9k7wG1yaIvLwrtp9GppJDWQ3DyC1jdAVE2OuIk
         jWZA==
X-Forwarded-Encrypted: i=1; AFNElJ9Gsi7pcAfM/DzTsg9jnEs9wNiql9uY6qrzOx7/vWXLxZRboiKDbqlglCxGI+DIUGL1zbvzUdKjjf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWc8CW176WTTWVyvevzLqfPxNLBgr0DZi/Qq+MiLZ/qiCXimQ
	f10B9wBo7CwoSpLTBF/Fh4yBHiKh3rQV1BIVz+C3rKkCcz35UPog+mYF
X-Gm-Gg: Acq92OHDOTSre71hS+Wl4Xk1NLZrFw4uZyoMW5vsCOQZ1/AsxgZl1jLQN5+Oa7j8VYD
	UgLDZ06HYybR0H7JhtP5FS/fHyTezE0fro9aFk+ZUvWSsKGwTeNdd04fq3UelPiACj3MKTcmsta
	A9NRaY0Rp+O6d8MBjbvlIszploq2gLe9jFScF5IMHeqG1dyIil7BSLXGFqiN5/lGGPklw2cRJQw
	aGTlU6FX262o19O23hpStL2q+kM4HZdgXnbgSuIDkmADVSCUQ6TYmY/xGs/GZ/POPXU1soBOrcJ
	Hd2QEGX8SSs72G2XKJwThM/l3l5EgIZwwmIoOI1+c5wk0e2zqNHExkLO9RAVaKjnEmW6uOqLctE
	x8tsxRLQomLgLNPBV5BmZ/XhXdGlk3cdEtCB4k6+k/9k25PpM049atcEZczaBvKjoy/MaTtw56+
	GCiDL6kVL+6f3aUT2vJlb61T6fSbznKrzFEJGD
X-Received: by 2002:a05:7022:488:b0:12c:8e70:c33b with SMTP id a92af1059eb24-131852d2e27mr14527532c88.8.1778508397470;
        Mon, 11 May 2026 07:06:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13277bb2b14sm18610981c88.0.2026.05.11.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:06:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 May 2026 07:06:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
	Joshua Peisach <jpeisach@ubuntu.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Message-ID: <a3055969-31ff-4b33-b6eb-6418cbf3597e@roeck-us.net>
References: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
 <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
X-Rspamd-Queue-Id: 6FEF650FDD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8863-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,jannau.net:email,ubuntu.com:email,gompa.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:33:08AM +0200, Janne Grunau wrote:
> The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
> existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Applied to my watchdog-next branch.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 05602678c070..845b5e8b5abc 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -16,7 +16,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: apple,t6020-wdt
> +          - enum:
> +              - apple,t6020-wdt
> +              - apple,t8122-wdt
>            - const: apple,t8103-wdt
>        - items:
>            - enum:

