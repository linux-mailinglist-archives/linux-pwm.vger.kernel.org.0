Return-Path: <linux-pwm+bounces-3136-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82596F8E9
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B661C213C4
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72291D1F56;
	Fri,  6 Sep 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yQio3kAI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CB1C7B68
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638371; cv=none; b=XLmoehCQdpPAxHEhmOQlotq7ysmuA2yrWyTVKGWqwpwwQKerdoPBPS5eXcwDBuKY4dxq7PouVO1+gNiyAX7vQyD1CBqYt+T771Y468/hobiEZXip39NxsLd4zH6nWUzRXVZ2UlAW9xLVdqYMqkfoxukiejqOZAZAraW9d0Yi3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638371; c=relaxed/simple;
	bh=F7TOto2gJdYDzL19q7b5Hq7OG/kUEwC5OLOLMKwb+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npULmoLTIV6iGx3/kHv1jHYASvF58P5rOt3Q+/KGnnjhHz5Va5HzT9WUgdBevyb673gw6KhQwWC1m7nTzTR/JhH0yS1U9tXxnso6yNyP9iJw/LILj4fr3+9Cer8IHkmXYME8mH5o1Y49X6oJWoEuvV06h3+Zp3pEEP1xv/CqTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yQio3kAI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a867a564911so287913866b.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725638367; x=1726243167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7TOto2gJdYDzL19q7b5Hq7OG/kUEwC5OLOLMKwb+YY=;
        b=yQio3kAIvXA2KNWTpmnFJ1DliztKiZ7KZKDzj1Mhh4H/CoLn9VEYNv27ZcLr7lhNs/
         Fq+ZhqlOY74ZTCUD2IVLY6orCGEXah5fwgKxDE3XKDXekQsUE97/f4/z/8vD4gIhtP7G
         OvRHg9d8E4BDcmy1faMkTNLNHIGvIFqXqdxLuS95b7xOwfZFtju0+l0QiY7QAWfx5JJJ
         A/0fr9qEsGzLY8KnvK3G07whvx1+F1+ewyhmKGdKyRJk9XQoNV8WMR/QbIWXkQFbpxFe
         UsCv2Y4IVuF8DQO3uRs4jArbIIwuSMGqs9H5lCkHDhzb4kqe23vAKMNO67fFFkuuCU3c
         UKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638367; x=1726243167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7TOto2gJdYDzL19q7b5Hq7OG/kUEwC5OLOLMKwb+YY=;
        b=CbenXkHYlgSQ7/YsPO+J5qZZcMnvUCty//j34QMYcSI62tUDMKXu+A7JcEFP/jYtrt
         QeSPOPdpWGObktLWsNYOaHARgSYgVzIRKdvR+RMSvTb7MwuNWm2aitGR4ZPvXBJaf48C
         1gvjmBWZHAnHnLqOshf0DFOpg3tPcSlM9TSGX8VEp/DSRYLKW7kNsu402qriW8mqrUhr
         TPcQFGRj6qTB9X2mDto8Unl8xpT4Pnezt6No8BobVDdiBGvdhmFLL63G8S2fUsQi7dU4
         p9tRVP254wJJFAkBRlsgi421c7Y6PfvFMshTijHTDPpAV8yoYZRTuD7DY7TVoXVf4tgA
         5pgw==
X-Gm-Message-State: AOJu0YzC5+su4+TW3Q2dtO/so/Rw6MGfy62FjMzvNIAZIfb5XUUxjmsL
	fq5UVlTxykqPHMJoSBcASIvyQY54Jf3d6uw0H2tn3cJa5RQYCwMaWSo44ZzjscYNgpkF7AYG77g
	Z
X-Google-Smtp-Source: AGHT+IElOuVW0/bvU5KZW0vs5FRqDmEDWn7l0+wenGnjMqDK6TiMDh3GYYeFc7VUmR6Y/xGk+UFE5A==
X-Received: by 2002:a17:907:36c2:b0:a7a:97ca:3059 with SMTP id a640c23a62f3a-a8a88667f98mr278534766b.34.1725638367021;
        Fri, 06 Sep 2024 08:59:27 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a70592a9fsm237226966b.4.2024.09.06.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:59:26 -0700 (PDT)
Date: Fri, 6 Sep 2024 17:59:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-pwm@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: stm32: Use the right CCxNP bit in stm32_pwm_enable()
Message-ID: <tv3muhjb5utix42duujkqqs4p2dvfecwafhqh5kvv6wqrd6hxp@6jaw6cujvubd>
References: <20240905090627.197536-2-u.kleine-koenig@baylibre.com>
 <07ad0918-c1bf-4ae2-8091-33e75aac4778@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4p3lzx43yv55222g"
Content-Disposition: inline
In-Reply-To: <07ad0918-c1bf-4ae2-8091-33e75aac4778@foss.st.com>


--4p3lzx43yv55222g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2024 at 02:40:01PM +0200, Fabrice Gasnier wrote:
> Good catch, I haven't noticed this has been introduced in earlier patch.

Well, wasn't so difficult to find. When I tried to fix my conversion to
the new waveform callbacks it was quickly obvious that the patch base
was already broken.

> You can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

thanks, but I was to quick. I already sent a pull request to Linus
(https://lore.kernel.org/linux-pwm/25x74hglxoyb33fphdrtxrpmvsqe5227d7vy6uo6ez77hjbrn6@dh637q6cvzax/)

> Does it need to be CC'ed to stable list also ?

No, the issue was introduced in 7cea05ae1d4e which is only in mainline
since v6.11-rc1. So assuming the fix will make it in before v6.11 there
is no need for stable backports.

Best regards and thanks once more for your feedback,
Uwe

--4p3lzx43yv55222g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbbJtoACgkQj4D7WH0S
/k6pswf/ahSJfbabI5hmfPOo/8K3+DFe9kw7Z/MXI1LXugsUYuAx2taakDUYePq+
pp4wC/3bK86r+rIJQ7B1hfzwbU9VkXGOzcewBGV43nC3C8AJmNmqtl9kOYpe41T/
kxmf+HJHATmH6FkmYf3oeZ5Oyi/yZUw73f0Lh4nED0XWZqXGXM+2EwgmQ652KKuv
izrwZRBmBxHg/BvIolfznA6+NEpPEby030VRXSbFA2NcdnUHUZfBqbNjA2smSCfs
yDY3yXhq6ZfRqPH1CqwFbBPqLjWMVvwCf8Wek1QiaVv6uIAb6+ToWieXGm7Uxl6D
bYbWkePlWDTNMLbhzMZzqKnKcn4gzA==
=7NB1
-----END PGP SIGNATURE-----

--4p3lzx43yv55222g--

