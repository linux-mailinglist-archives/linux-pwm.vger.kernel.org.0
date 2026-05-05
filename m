Return-Path: <linux-pwm+bounces-8778-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPJxBt7u+WlqFQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8778-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 15:21:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DF4CE5BC
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5812F303D731
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10903112DA;
	Tue,  5 May 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2914lqM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABC2FE579
	for <linux-pwm@vger.kernel.org>; Tue,  5 May 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987068; cv=none; b=A1dykN4zcxLf5zrgK+ISMdJrcQ441gCz2Xwg/JBZXrAoXEBRaG2KPdll+Je+QQ8B02SKmgbx+jaCs/lZj0AcNV0Yj3/1iY0UQJ7DGBPgNGawOYqHgZp6pjYvtvL9v/dalfz+J4VoaEe3TaZYJ5Np+sdgpGqtLsL7XnynzxSe6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987068; c=relaxed/simple;
	bh=yZlednh9nVTM+xIY3GdlLz29I02HRrnjp3HlVqr0/w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHK2QEuUSUsuNXM+1qgJM9xTe2yf/mBy2czO59uszgL9bDDZpDaKY44RpsoN0OA1s3rEhrcGpP0SZOnMLBiM/WEPeVCtwM90p1dZJwCeCKVwiGbfgRkTl+pYgjBSJUnNERKCdXutdLEJu21950BiKrQ12jaAcjO/Mhf0HZKb3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2914lqM; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12ddbe104ccso5306100c88.0
        for <linux-pwm@vger.kernel.org>; Tue, 05 May 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777987067; x=1778591867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7Uwvr8MeFsSApFn56xtx5NITAqS9F0rWz+pR67Hm0s=;
        b=W2914lqMxdn6jzV2p/uMJhBAYPeoJte1DKvNPnqhHKZoGPv0HLoubgHF7GucKQgETq
         +ogT6hUG8mEw0XitLYxWn2Cp7Ee0hHbXwwPYEIqXKBbYMFxigach3S0imqSDH6zGoAo6
         /FSY7k2EDEX3zBrnweN9hccT1AuG88OZnyBGiCoCKFIpfNBH9N17ZKnNjfVb4hfKy6Os
         M1+k5DSa+BMF9ngXeZYPYH0b6sjoPD04Ob8ayyiYdkwtTwhqdPue0K5rt3O2Wi+/87FS
         /OJMp1tyvOR4mUchXt4NgNWPHRpboA+96I/o61rJaaR89gdYz6xv0JcD/aHs5aLtK30s
         mRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987067; x=1778591867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7Uwvr8MeFsSApFn56xtx5NITAqS9F0rWz+pR67Hm0s=;
        b=OfQdllg9NnfsRwCxi1Xud/60OQm0RuKLkADjTsdFuXb/mRUQEKAZRvwo9vTlXEvrpC
         ygIsoXpRmdpU5DPSP8m5wg7Lc+7wiUkTH9LA6UCPWsbqnyvsdsDiPMdpnmPlO1pqVlEb
         kRxujOJA6kV05JR+1HHgNgxUolCUZXzkcwHoKuR+9cqNYaKGd29zQV3tAbCkWZtZ8Av+
         EZe3BLOhmektbBjdOMtRYjezfUvf1kKGr9CqffNU6bDZ09iADGcHOuHIKAgu3eDd/wzs
         zTT/0igJwSrhnjXYG4k8DMxjlpjEfIetvwXoccRQx1JqoT4XK6xHs/J3ITgBF/kGMLra
         ix/A==
X-Forwarded-Encrypted: i=1; AFNElJ8/VUctUf/sfTM6LgDCFUX/POV2K/A3nbpQKNczNuVtC+gdGQWeCfCCcc1SDTuMMCKzwTlw/CYYTvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJJt80hcQsy/bTbMtsLmsW2VEOgIEyLx6dmr45qRZLyMrTR66
	jnykGiGv7sbiC4gMqACk5LHVAqbJbj4Mbu4w0AlXlsuC9ZluGYio4MvBYtRVFw==
X-Gm-Gg: AeBDieu3SmXEtauVPHiRJtjUn0zvkUYicS8BgoXBg7thcXTtA1nOkk7GZrp5QB0tQUi
	Ao98IkjtOPH00X/elqiAAakxAMvg634FxmFtlhlwGFRdXyJ+3ocmoheHIoHznFJrtgwejXfzMSe
	COro51g71xZ09V4rQb01UMBnAaEihrHL0DfL9pBZLLTky9e3dr2KBBRpaaN+XNYJJcAVU1PhO8C
	0N/Uvgs11Jl+jMizAzupC/U3QCuJExcVEgp3vZ4e+oc7nZjdp7ql/Ww14IyGZlCCrS6mD9K1Yj/
	E5pmGQUXpn1WysYMpwwqoPz6w2aPDFkQYxtELT3RPtm3ZLYp2vZGMz9LRADmfVtE95oDWNSWxiM
	hO6VqVOzBJ1sofEQHYJGEi6XivPuexePD57FLOE/9251NgFTX6jjAAlRi5qRPBN8j522u6rbts5
	VB9G9/b3fKfbR06wNcWvSTX4YQy/70GWED+LodMIwap9/fUC8=
X-Received: by 2002:a05:7022:238e:b0:128:d352:bf8a with SMTP id a92af1059eb24-130b1c72299mr1458737c88.33.1777987066539;
        Tue, 05 May 2026 06:17:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm18173052c88.1.2026.05.05.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:17:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:17:45 -0700
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
Subject: Re: [PATCH v2 3/6] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Message-ID: <5856030a-4d3e-4d1a-928b-f9aa0b21f1a7@roeck-us.net>
References: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
 <20260505-apple-m3-initial-devicetrees-v2-3-b0c2f3519e0e@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-apple-m3-initial-devicetrees-v2-3-b0c2f3519e0e@jannau.net>
X-Rspamd-Queue-Id: 809DF4CE5BC
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-8778-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,ubuntu.com:email,gompa.dev:email]

On Tue, May 05, 2026 at 01:02:41PM +0200, Janne Grunau wrote:
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

