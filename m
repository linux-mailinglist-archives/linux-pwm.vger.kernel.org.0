Return-Path: <linux-pwm+bounces-2554-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677D890F369
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688351C22259
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693415886B;
	Wed, 19 Jun 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Giu7MEVV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8C1586CD;
	Wed, 19 Jun 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812160; cv=none; b=hxqnNqfWskUQMDa7sTjztVzadXp+BAvhD9LtfUIhvhEYL/pjz6Vh8XGdZZsaauXHmj0LLRvXUn/81+oMZWV9YUxUsSxe3oH2+Lwh9zNiHzNfRKXvzfC8vrQ0oJ5Uw6AKbp4Yuz6KCS/Y6T0YBIqwYQOIeGrxbLE5DuyP3xaI5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812160; c=relaxed/simple;
	bh=sCo0S/t/wVuMA8QyWX9utK/82LOwdLvNdRyW93Wh9Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvJ+ZJ4luCQz8jiND4nL6yYkxQtICTCIDOo5/NLR0mj3Vza7/Dz/Pm+FJK/E3SdxC00jzLeMcj2LYGckp1qDu3rjN28FlywFMjVRdcOdYj9OlSt6lYZNPUParPP1acOVlEAOsKQAZGpAanqJNdT+rLc/5fc+clemOiBUEelunGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Giu7MEVV; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80d6c63af28so2528192241.0;
        Wed, 19 Jun 2024 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718812157; x=1719416957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCo0S/t/wVuMA8QyWX9utK/82LOwdLvNdRyW93Wh9Zo=;
        b=Giu7MEVVW4CDe7/rxoWgXS+g3BfknXRz5SScKP9PTDBZ6+T0hjUTcqZXAhcTvKh+JA
         xnnI+pJXlD2w7sq70hBGcLxYjGuzp+smoB0aaxENhSORF+vhQ5KcXE9btXcY4vaPWlam
         6H51BZ5lkF/mGW2+7wYUwrzQ6jmz5zU5+Lrmw8zVCSCHJdaDdJhjQxu+PdQQfXt+oGzB
         tEKz14AshBDyVn2d27Sk4pcdoiBqbiyV38scuI56oTipWtA+vzQGJZNDs58GvLJMUIxE
         ecPwyS/5F8RRmGnNcla3IXv4v2LRIJPBXpiogYBt6OxipSL0aJ5sWI694cazCo54hOtR
         zKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812157; x=1719416957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCo0S/t/wVuMA8QyWX9utK/82LOwdLvNdRyW93Wh9Zo=;
        b=J82jj0LT/P6PFDqXvLRDP9I+G9MrnFGdgzbhB9iF7G0cC11K9N08/9gr5Hy9OfNFVb
         KXDGMAjKAYChtHXOR7Cl8ya5h7TaVrHPT36QML4wlwh+sxYDC8i4Dajqk40WSJf3+mgo
         DMtVHFPtQzBmba17f3ilEgdu/NtQmBmBnwI54fHxbBtblX/02WZlGlgWNMYmNxQKNbp4
         jic0SZaxiuH841hz5yQ8jvKN4S30CbjP3n3cOXnMw+7eLZRGwKDLIfQmb11NrqUN3n+7
         3hotV7z+/0UhdM9JXRsKSw4Licn6vclxt5MZMj8BSJgnjN2X1QmZ1XSD5XP2enCl5hAS
         JpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNfV6/zxzeq9u504Dn+20+/NXomd8Rl9abPCmzU75Ls1SMzX7kEQlP29HL2l+xhplW/Un4qnMJbxXi7zvzDx0IVcaUF20U1XldnjFpxf6sjwXBCdqvb2zDEyDYRDVyhD4U8Mv3L9AKntC7v9msHUXIcUzG0rNnwWbPIOFd9lKR8SQfTXIYAwW0XRSaiBNWvA3GDeS8znYjDSSQ5hKwUezvY0Tq0lTW1k0MCBeG+90uLfi4IB6nM4g0fqqpPAAIBV7ACPR1trIYR9nDGJrfY82PwTDd+e+q7foHL6QR3rsVDG0Lrt2wwsRTqX/BSoa4Z6iPFvEL5tk7iIrYYAVkQzqsAzcFT0MjUR42f3iJHehuNBGAfobAkmpcWyLFr0fXcvm9yDS+bqsp9khF8RHWuy/bR78qCOphvIQ76W1UpQz33RbuHqw1yntFHvXGrpSm/Ko=
X-Gm-Message-State: AOJu0YxQ/SnjNJ4BVcTpeDyEKgsFkRWz5mqL7lQLHR9BGg2ilF0YpSo+
	eJ3XmUMeWVOOOLDirrWQp7pmeJbomedVaZtjVUXA1gHRe7bmBiB48uP/4ai5Biio6wtICX4ASuy
	UiS7IGZq7NC1yrytmrED8gw8Q9uk=
X-Google-Smtp-Source: AGHT+IHg0GWswSl3r9pwlr7iQjchG/nGHT//aM8i64MYsXIGAJArmngGDjmCxE9ZpGaKh9pHgPCRQReNLVUNTwTTHm4=
X-Received: by 2002:a05:6102:26ce:b0:48c:40cd:e4da with SMTP id
 ada2fe7eead31-48f1304b1c6mr3802757137.19.1718812157407; Wed, 19 Jun 2024
 08:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-18-e3f6662017ac@gmail.com> <4eab619f-6da9-4aff-b956-69d8e2ecd47f@sirena.org.uk>
In-Reply-To: <4eab619f-6da9-4aff-b956-69d8e2ecd47f@sirena.org.uk>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 19 Jun 2024 18:49:06 +0300
Message-ID: <CABTCjFDUKgeYWuwo8eLt+5WD=4O+kLbFwMRxsTufGnqK0Ecpvg@mail.gmail.com>
Subject: Re: [PATCH v3 18/23] regulator: add s2dos05 regulator support
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 18 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 17:08, Mar=
k Brown <broonie@kernel.org>:
>
> On Tue, Jun 18, 2024 at 04:59:52PM +0300, Dzmitry Sankouski wrote:
>
> > index 000000000000..3c58a1bd2262
> > --- /dev/null
> > +++ b/drivers/regulator/s2dos05-regulator.c
> > @@ -0,0 +1,362 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * s2dos05.c - Regulator driver for the Samsung s2dos05
> > + *
>
> Please make the entire comment a C++ one so things look more
> intentional.
>
Do you mean enclosing the first line (license identifier) in /* */
style comment?

