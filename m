Return-Path: <linux-pwm+bounces-2845-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651D933FC8
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7283B2212A
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069FD181BAF;
	Wed, 17 Jul 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+BIZjQS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F6181310;
	Wed, 17 Jul 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230544; cv=none; b=X9Il2vEO/oEPUrpfpTG3TjWlytL6dVVXh2ux6bUTEuzLKKfDz5J2EjsKV8p/pMeep/kVdgCpADUM9NW0Ellr7H0p7eNG6VKVTwWFQnHgo6Kb57ewYJOIpfcL1jEem/EglZbVMoVnFggx8o8mtyyt7LDG5MP3kOIFooemcTgU1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230544; c=relaxed/simple;
	bh=igKSkhh6A1mnqf1e706OFohGjxcTqllM85CooIxAVwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1WLpqNRtFvVWYUtcGHjtffrSv7Bj7kF1WE9RDU7I+7a5T284c6oSBOnSHyRztswPMFbKlFvyxdBW/iHRRvztnwWfYmw8wDSsJbi+Immy+jI5Tv0rUMgw6eMm3j/3Zu8Ve6OxwrNf09SFUXlBJyXsD0raDBkr38TP8/3bfU0yos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+BIZjQS; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e01a6e5da1fso833208276.0;
        Wed, 17 Jul 2024 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721230542; x=1721835342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igKSkhh6A1mnqf1e706OFohGjxcTqllM85CooIxAVwE=;
        b=R+BIZjQSFW4EfFtrZdLzkvkJXLRERx9q1YTHmg4OJGcGmlB61G0s8aSyuBCOJhW26i
         4K4VwHikf7KUVxXqN6niF/o+PiOcYtqX1Ra4hwN8hJsbW1Lc+Mb5pe9nylmRoJlLmlbD
         EFHGMSiMGKilCiYWwlh+mrT8uF6yq09YOdlE8JeyBtcKXpRku9JbolSKKJky5ThmKcin
         WBOmxriEN/nJkF96Vqq6dEQgrsF8JzwYZIQNkhYH7KQi4np7fi8TM2DJWwzDIDPAFYT4
         i9yptDtegAKTeRQthCt+JhLFyZMyHEvKY/wUdIwZyg3ExXLRlYNJ6oeX3e87ytCa2QRo
         lJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230542; x=1721835342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igKSkhh6A1mnqf1e706OFohGjxcTqllM85CooIxAVwE=;
        b=OdhzzT0AaCpWXqzzuAoFMieGwSpQy47vkVXjKE5Dgfn0AnU60TLK/aSUUoWV6prjEZ
         dW9OIV17euBrUjFXEGlsyMi4+/5hunQNT/JLi2VCZgkRkCCndUJ6MzLXex0ieAZNr2FL
         Zs6uyJ9iE0MMBKF6wsZsdplHjlqgvcm54/1dB6ERO2J7wH/ii9DTAW15tusmHwmzJ5Se
         V6AJK2tzR836EPTec9tsTTWuSQ/BDnjTkN3z3izzStLV3JoaGWrAm9xue0reP03nxf3r
         lcI2LSkBVN/U/rYvObyDnFt3d2S/O+vvxJ8RgCnvsVuk4t8DGA+zIYqUPTr/nj7YOlxr
         2O7w==
X-Forwarded-Encrypted: i=1; AJvYcCUIhSK4wIYbvfA0L5iQvBkEKIXKZSWpEPXTbn06YjGotpFhaaZ/7kTwJcgpsUQ+9HkfzM7szqcoHmBP@vger.kernel.org, AJvYcCUhYc+9cZzNfxKSadd5z9jjKCDPfBYHy4vUnKcJt4MdpWpQJyuptVEbdlBFZRcYz39qqXeGphJgCVUL0A==@vger.kernel.org, AJvYcCVamoGR2gsgfrZfm8XEz8LMVyjKLvwzu29Od2+/SqqhndNP8ZhP4gSrhTJglV2JAAMJpiot1QY0iJ4j@vger.kernel.org, AJvYcCWfVew/XBxCwr/EKJhX9aFjpcVeh+cLRutcZHkAqhmHOjgFHGYt53YnHkmSHuFLDdqrRnXpoA86B2fezgOg@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZRPHzz3VtKrNmpvpXBCDTJ3KWkco7IY/p3p3RoYcf3xVvWCa
	0QlXbPHO4KO/owJ4gpj7ta2Fny7HtTlJwY908v5t5xZuANCw8H7S2xbrHIz3kuKEq8/RvQbXjny
	T3gQ8+Q/rA6TNK5l1OFMix/wfIAQ=
X-Google-Smtp-Source: AGHT+IHe8OrFLg3ciltrH9UGah27A80WUE2vi6fq7nZNul7uqH2m67h9SsuJFdyNWxvxpLOezUdSHmc4pDBlQVlAl3w=
X-Received: by 2002:a25:d34b:0:b0:e05:e16f:e8a5 with SMTP id
 3f1490d57ef6-e05ed7a649dmr1163650276.7.1721230542549; Wed, 17 Jul 2024
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716-adi-v1-0-79c0122986e7@nxp.com> <20240716-adi-v1-4-79c0122986e7@nxp.com>
 <u7xii4lfvjk6gbpmq7qtqckoznddiyno7xsaa74ufuxwdob532@wxuawwiwjpgm> <ZpfVNHQQaJvdnB+B@lizhi-Precision-Tower-5810>
In-Reply-To: <ZpfVNHQQaJvdnB+B@lizhi-Precision-Tower-5810>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Jul 2024 12:35:29 -0300
Message-ID: <CAOMZO5CGqMXmcUg=J0OOtsq4ZpnVD7GnpxzEQQQ1Cq_dR45Hwg@mail.gmail.com>
Subject: Re: [PATCH 4/6] pwm: adp5585: add adp5585 PWM support
To: Frank Li <Frank.li@nxp.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Clark Wang <xiaoning.wang@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:29=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:

> Thank you for you review. I just found someone already submit similar pat=
ch
>
> https://lore.kernel.org/linux-gpio/20240608141633.2562-5-laurent.pinchart=
@ideasonboard.com/
>
> Let's wait for laurent. If he is busy, I can rework base on the above one=
.

Adding Laurent.

