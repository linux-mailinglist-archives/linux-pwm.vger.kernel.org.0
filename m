Return-Path: <linux-pwm+bounces-8853-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL1AGGukAGqTLAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8853-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 10 May 2026 17:29:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B3504D6C
	for <lists+linux-pwm@lfdr.de>; Sun, 10 May 2026 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA2930097CB
	for <lists+linux-pwm@lfdr.de>; Sun, 10 May 2026 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA739FCC6;
	Sun, 10 May 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pepBsWGr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905337267A
	for <linux-pwm@vger.kernel.org>; Sun, 10 May 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426984; cv=none; b=ckH2HKtwmdEYbJ50POdLHNYXcgLuVH8WZVOK8g83xCa141nOTJtsIkio0N1Dva3vQ3YEs/Ced2D6nwRd0IF9CioJIXFyy42irrRNEE1OW4B7cSrcTKIjnwM+1XMETAuInYyZx5avVdxmf2nQETIe/1Ei6ILV4JpgpdmqHUR2/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426984; c=relaxed/simple;
	bh=VGhBlR4i0yiBkTCF4XD51IEzNUwKDosxwd/fQ1UG4tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwfFDwdYc6ZB8KvUz5qmlNJiFeRQxVqDxfGGqVTWHot0R5rhDrur5KQmN+R9hMs4UUWdLjB92103O23AXB7l3in0iWkFF/j7rluEN3EE+fA5HWPy6sOdNs8ko8uf0b8f1lHxJoh/pFGQjePv/hrTPpmRT8Tf/Bz16qVfMNjQjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pepBsWGr; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3553591eec.1
        for <linux-pwm@vger.kernel.org>; Sun, 10 May 2026 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778426981; x=1779031781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qigH8lxO+eZS/TR71vYkcB8nPKNDMGG4EcHQASbQAqg=;
        b=pepBsWGrmAbVKZYsiVfg7DKy0Urzj0tyNGEP339/vLv/GqYzRTbZjOxlilxdsAvVbt
         yIulLNIPlBjBia5gPiUCu9Z+afINU4irsdhjZ2LeBlF3lP02+v74iMg0Rk7DFWd4Om17
         e+/Fzw6mNP0KBmeF1B4Hl2HsIXBieVbnEAEEj3cCUsAueWdhEQR6NtnjVW27O53Nu7ha
         nRRFmiH0+l3X3Ay5yaeH+7DMG6bLMgoXDIgaauUkCgJAXr/ZD/dPDsBT3SixngvgiqfW
         sATdsJQPTf5LcRL4oU5LPihftzRv/AjqvScXfjH0KjD91G5ftojUa2P3mibWMVA7B7IL
         98kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778426981; x=1779031781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qigH8lxO+eZS/TR71vYkcB8nPKNDMGG4EcHQASbQAqg=;
        b=i2Yzg5aJOzmxz3UTnMpWcecpclvZb8jGLwwxjaHbkkokEnIZ6CMn986VEarvrSLSWo
         DquVX8SZ/PBw9quR/L8VZOPII2+9954w3ddUkLlRA30o1/kHrRW9M90VN4BOeGZqmLBH
         Q8W9FZwq3CEcEVDFYSQvVEbwII7NyWEte5GDWpT+b6jYtxwUgWWUUB3rCSYQWLNCzr0e
         ELnlQNlhcIVGPntrEoOYl1BlrhcV6wsfTrbcn/xNhUuaw7BqQUf3ZEYjHv9EecGK9qII
         Uz+khhHmd1p7N8vgMX1A6J5sKHPXoMHQAzqTd2GDWNkBC75NjG7hVzVGa9k98+HNWG6C
         Rmog==
X-Forwarded-Encrypted: i=1; AFNElJ+PCIamIr57VBNk4UvpsdI8rDNSqdYkK0eluju4NS/5Kqz5Hoj/YpnHKO3mDKDybYypGfUhm5DJw9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykLKxc0E+D9m+6xixYOfVmBctQw9wCBYRf6Ugc7b807XPIkvz
	uY/Ve2SjZ1rRRiY1uraz1utJRt3ls7RfB0E3XA7Ncf/H6lx+dPyl1saI
X-Gm-Gg: Acq92OHUBp7YO/IWIEVbpHtm9R3ffYW8xmdOzCY4VddwoCUoCYMmvzf+xOwniTSIgUr
	8mpU/0DlVJEZPSN721h6KYzxTKhzAeWO1krJkGddzlV8bnLTXYS2agnNkIY0/9CT4CWLqZpQw6t
	9l4I6saw1KTuIQSYN8PzPv6UOFA7n4E5+0FOuZqSJU0gDzeq/5+nUWbaJWI49EU6+1mXk5eat/i
	SmradxVpJTeA9Ke2PHU9IMg8rctoDLIBugmyaweZIVQITISHfSHbyQJ8KnEustnCAhSXKCJ+ruK
	EVYSRm3SP/HOescFixHgYyN3z2e4Fiw59yXiGWTggc4/rIce+CcMkbtKubV9KHTPYCyKJthpSVz
	cqJvvf4Hwyx/S3KuTaoiXcbG8Tj23d6swl6YTMqMfXCc/KsAe48RRy7Upq3f6cte2428gO0hHce
	XNUfXsPzb3sZrbx87EwEFtfiWuidEP+B6wZu8CequLJrJxlDI=
X-Received: by 2002:a05:693c:300b:b0:2ea:5057:a2f9 with SMTP id 5a478bee46e88-2f549f7c2aamr9650588eec.16.1778426981133;
        Sun, 10 May 2026 08:29:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm8525864eec.0.2026.05.10.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 08:29:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 10 May 2026 08:29:39 -0700
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
Message-ID: <85ea46a7-1136-4ea0-9eec-7dfa465df20b@roeck-us.net>
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
X-Rspamd-Queue-Id: BD1B3504D6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8853-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,ubuntu.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:33:08AM +0200, Janne Grunau wrote:
> The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
> existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.

'"apple,t8103-wdt" used by the driver' is not true. The watchdog driver
only supports "apple,wdt".

> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
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

I second Sashiko's findings that the driver will fail to bind because it
only supports "apple,wdt". I would not mind and apply the patch anyway,
but the statement in the description is just plain wrong and thus
misleading. Please fix.

Thanks,
Guenter

