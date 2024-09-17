Return-Path: <linux-pwm+bounces-3283-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF897B1FD
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FA228381C
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B321C9EC5;
	Tue, 17 Sep 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dzNROLnS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D61C2DD8
	for <linux-pwm@vger.kernel.org>; Tue, 17 Sep 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586166; cv=none; b=TjLFGmBHqvuuVEQC0pupCvCJDoi0ZghFP5euk6R99Xbnzwbgi/86tv5QLj5oNw7b8j+S1WNWBjtGXiOOR7Hxw6dwzxY26XJyOf10WXjtuckFu9z2EntGRs2CHb2IMGJko40G8zQ9BEDgdMdnU0NFpvX/qi7FIuf2Ls8y70Irtmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586166; c=relaxed/simple;
	bh=BHulxewA/TznO0Vd1SKpkcERt7nE9S/q+tUe13aDxgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkfXOLCsndcTRdM+VLk7W9nxPuW12ditxnYlNRvvFwpV/TtBw9XYGKY5aJj3fhe/UxkVp55KhfEHgDQ1SYdQToV7RJsXKkCocUZLXmU2WrJKuB0gLSm/82TnRqNG6Gq61lfkBnnFTVA2uCWXuiJC/WdP7JfxJY9R/Xkw/Oouc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dzNROLnS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a843bef98so601447966b.2
        for <linux-pwm@vger.kernel.org>; Tue, 17 Sep 2024 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726586161; x=1727190961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHulxewA/TznO0Vd1SKpkcERt7nE9S/q+tUe13aDxgM=;
        b=dzNROLnSc8xG6JZXuCXmlnvrXRuoGMzudMpWHui8f6ASxlUXBllRMz1JYrOxamY8uD
         NOnZ6kwTHlY8BFNVJfyqVdSDOmwK0eKaxbHSmMN//9krEvwBE7o6tUdlr5rHcUCVyM5r
         IHZp11lYaeEx05iCzqXsuapNnkGr5TvJYpo87ZFoXVv8PLsseINouvpVOpF1khYz13ui
         uw6B9MidW2bK64I7cx2hZ7o018VLmDUhDV/oVUpnuCzPDzsvZor3xViUaOG8p07BQHGe
         WGsyYSJU5BgbXqTr8uQiH8EhN4A3xj6QUl1dA4GqFgTZMk2ip3Zv3QKrDYwJy4BZx2G1
         O8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726586161; x=1727190961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHulxewA/TznO0Vd1SKpkcERt7nE9S/q+tUe13aDxgM=;
        b=Ep3W3rr4ZCIZc9N653TFLMe4f9Z6iEE9DzGDa9Qp8r25oQ2Z/lv+PKwXoq3GOjYiE9
         yj+Q8tHlLL4+SHtWGbZy8H2eTRL3ovLx7/1etfaknATMluPQrd37YJ9h+8QLVZB2su4B
         s1x/fcNiLondnCCJKqyTM8qCP++KunwUpRZ80OqvVU9TneOCvOMr9cvDlZG146I7xz5J
         ZXw8kf593uBRZqrFV1I68vMXII0fctbPX2lXI0BvZPEtCgXmv/i+vW46MfzaAgnLeW7S
         K9Yz73fUmrRzHkQiMmpMaWmsAH/pZSGomWd1rPBdBbMX05Sq7UH3PnBbo2r4J/rLhZRX
         iGpw==
X-Forwarded-Encrypted: i=1; AJvYcCWgnhDp+zKJ2mSwzQP/NghiuCXKPXFz1DaGEi+x1k1HoLrl38i/UuuvF5wfYijgu2tUfXCkrIYUOJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7eRrjhOSPWCuieqC7gpBT5/E7gXEhJLe4AHx0TTLrkF66gCg
	DzXZNR27+/Lgl+1Zj+4yT95EtuUvGtdEBm0e+d7Nl+d8iX/x+PLTSYOySPclk6Q=
X-Google-Smtp-Source: AGHT+IHPEVRV5SnmeE41rHg/+adxtF9yuzVAFT0b91fKlCbyw2kCVFjjFxtULs4ctjtIniGFRmiG0w==
X-Received: by 2002:a17:907:3fa7:b0:a8d:5472:b56c with SMTP id a640c23a62f3a-a9047ca91a1mr1827350066b.22.1726586160558;
        Tue, 17 Sep 2024 08:16:00 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f440bsm459801366b.86.2024.09.17.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:16:00 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:15:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] pwm: atmel-tcb: Use min() macro
Message-ID: <ctq63nbymavhh5ikg4zycoq56h3wmp6zhucqsjrbkspmf2b7qc@asldgk2z7jku>
References: <20240827075749.67583-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozx5bdkryl6kxbsb"
Content-Disposition: inline
In-Reply-To: <20240827075749.67583-1-shenlichuan@vivo.com>


--ozx5bdkryl6kxbsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Tue, Aug 27, 2024 at 03:57:49PM +0800, Shen Lichuan wrote:
> Use the min() macro to simplify the atmel_tcb_pwm_apply() function
> and improve its readability.

applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-nexxt
. As the merge window is currently open this will not go into next yet,
but I'll schedule it for 6.13-rc1.

Best regards and thanks for your contribution,
Uwe

--ozx5bdkryl6kxbsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbpnSsACgkQj4D7WH0S
/k6q/Af+NQHGFrL/T3ofm5LBinf8ILU9v516yAEw72V+Ifa4JjX2yz8yLo7fjp4i
gBT1dUg6uXVS5ArJByFXCk6dzcl9AuJYPRnr0EpOnQb6lr6S44bb6xVQ0O8UPUHg
uYt18ISsBIsCaOIgNVmphiMq7Uf66LMqSvKqkiUWrZ3pyc/17R6gmdqKQchlDNne
86yv7rNx714M++6LVDS6zSs0AJW7pjv8ha0tqYxh5WMTRtzHmGy+hoGJ01tCt33F
h2uUrhlRW17DPQ3riCTIN2wz13esfOXaBhRoKcC0QAB0Rjym25Nl/GTJgsfApwKV
sxBtYCQBKSIk6kWrD0H12DqvwaKvkA==
=HSkK
-----END PGP SIGNATURE-----

--ozx5bdkryl6kxbsb--

