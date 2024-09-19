Return-Path: <linux-pwm+bounces-3295-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01197CA00
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2431C220A7
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A719DFAE;
	Thu, 19 Sep 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2k6WjgM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE2179AE;
	Thu, 19 Sep 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751878; cv=none; b=rYjBxAhVyTeBKVkarcO4aFvqJkSezto2ONt7j4a4THMIyq2p/2uXZArazfbPACGAmnmIRKeGCMHgFNCjGABFRzwdNPkJmp7olohkkHYeunklsFKC4HxKsSGFZtmwYg1LdJG+FHFIEmVquu0x5txPGkQYN59mRJDaBVKUa77yPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751878; c=relaxed/simple;
	bh=8RMp6DtzWha32Via1txQCdHxjj/HpMtXKzFb3Ncg6pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7oMNaykL64mEe2zNmwCDEVBnp4rHoukcD1+tCQKmDOfDBxQSH6gsIzeiVAf1rbQChyYbEPy6yiakXr29DZEocN5N2aCu7QIydG1nhk2phhvC1McbiK314ReUxxjDgtyq+Yq+OEQuwyjmU/kt4ziVMRl86MMAHMwnIT+xucJBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2k6WjgM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a99fd5beb6so166887685a.0;
        Thu, 19 Sep 2024 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726751876; x=1727356676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=anfCIpzkOCIiGL9EDPttCS594d1L2okUuXy0ncEeGXA=;
        b=a2k6WjgMX/6aSU1FZ8m0ofRnfO9HCGtDFY99hBd4dz7iXD9yifokzlc0HE6fAOwvbW
         PLN+ykaab2istqyQ0vDtKviF62JziNXWPkcpO1L9SSWQORee/vo+gkCTHDSJ2TXgHe5I
         RfzXuTNaRL6eAThEQYZv7pQRRqgoPVY0WgNkfKxY98ujhXCE98wYxIGz2I7BHlXflvGs
         bssqWyIUCSUmeBVxRxZ3GXfnmv2Imyxzk+LcRGm6Nsy5D+z103lyDoTwtRT8Q/vo8abv
         gw2KtjvMAsvXdEMlxbzvC64RKiqCeerP9/IH2uXS8CSsH8mE8W+6m5b+z4J+UtfTqrW+
         1YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726751876; x=1727356676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anfCIpzkOCIiGL9EDPttCS594d1L2okUuXy0ncEeGXA=;
        b=TzeQR6/yIdR2denFDdnonZ0wqDJFB5p7jdhhtgSAwseRpcko2zazQ8cv/0e7hNG3dI
         R8YzcZ9nkzjZe4aQzNMNM3fBdAgO6SWZQ1zeOKlzehQEwJ2b3VdrABEBdJdYBHnCtEuw
         +z8NIRDiXawHlVPyGk8GN6Wq6m1gKHIseqd9S0c94zBBK7gZAry/kssdJl0vi2Oayos/
         Z9OBSOgF2F2XxqVKb+RBCZWwus5W3gufgkhY3Wxq+1O51qvM6DFbsTJw+GVwXSNzywmG
         /dfKaW97fCoA47TNurmwT+uIvvUrX/uzuHQ/LP+BJ+WHGABGlY1uit8R4yj+jrHCc705
         a2tg==
X-Forwarded-Encrypted: i=1; AJvYcCUVcXknJUiMsmRSHTvl8HV+0+m96Sk5vAL+P4s8nCR4/T994uCTIrdB+S7mVYi26YdP1yNcvSAdtemj8cc=@vger.kernel.org, AJvYcCUi8XNvpifqpLA48ULy1e9zRNpB0vUXlXAst7RydrF9o0VNu0C98Pc6Mda6hhfDr6ktq0dQfphq97scRB54@vger.kernel.org, AJvYcCV+tA37Dz0H191AB5jARvvdkIdNzibyt0gy3GKhQ0LDgrQKLDp3nhcQBNWboOJiEfh7nsVnrw8koYY=@vger.kernel.org, AJvYcCVt4SxzhPXDPU2CEQRiZuRCFfmGr5xvsR7L/YEnRiYRWXl3CujW/fHWccIWhVWofMHRvfMGb/sTZVAZ30H8hQ==@vger.kernel.org, AJvYcCW+IFMVOpjM1WF3i6WYkb/rZutccb7/n+ZutqA0hcnm7qpMY0Ev9+MeU3J0pMoFv+HHJF0pbG7yJXpcmL6BUJeyj4s=@vger.kernel.org, AJvYcCWGPE5g6LNLgVbbhoTE0d674035HJ6vgfz/UEeARbSSX70FrTHU1bl/nZ4ybVUShSslXwwvgSDc2t93@vger.kernel.org, AJvYcCWqyX+36ywZxFH0ClvGSP3PmUYpk0jm3CUY6+kUXz65CBQQ2bppqakGa/ncvcZOZNKzajsOLFCA218e8A==@vger.kernel.org, AJvYcCX9d+1J79SH2NxHZ7ZKCvUEhOhERlYEKJpz6M83i7Q8XbtgzJOrAViyHD6jWjSk/TJXQBKRXaSkUR2w@vger.kernel.org, AJvYcCXxv+1yVPNgg9I5SvXlzTeYWDhh2/ERUlCXqBT3S9v/lBN47T/IE+vPG/h/l40v7l/uSZLpZUm+9ucc@vger.kernel.org
X-Gm-Message-State: AOJu0YwYycFoAXJR585/2Yvx2Maq0pa5LIKQncZRD8fyTND7njdx4DHG
	rvcOYXmPigTq9PZrDejBt+0y/Utpsg14hp124VghCjOO8x7IfHzVL4b/c09JCiln0GNuQC7yyPH
	WQ57xsFfEsX4bi1qiEn7bl+Ta+kA=
X-Google-Smtp-Source: AGHT+IF9IGnoFymNrY96ZdfBvRdXpeFvTASmMi6xugMQ0/+PzTD5PFJN6ulZK08RbShyMHH/uKX0/0RAUmq5n3tkuIs=
X-Received: by 2002:a05:620a:1728:b0:7a7:d6f2:95f8 with SMTP id
 af79cd13be357-7acaf5a0246mr459527785a.20.1726751875987; Thu, 19 Sep 2024
 06:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-23-2d2efd5c5877@gmail.com> <rfoxnd4axyqxvexgq3mm2zntzvpihv4g424hepkoh7bfr2izjz@htjeqbfuq2gu>
In-Reply-To: <rfoxnd4axyqxvexgq3mm2zntzvpihv4g424hepkoh7bfr2izjz@htjeqbfuq2gu>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 19 Sep 2024 16:17:44 +0300
Message-ID: <CABTCjFCwg9HJcAQOG4+jeHviPiXoSiQgzX-ogUPQt1M2494aBQ@mail.gmail.com>
Subject: Re: [PATCH v4 23/27] arm64: dts: qcom: starqltechn: add display PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +             pmic@60 {
> > +                     compatible = "samsung,s2dos05";
> > +                     reg = <0x60>;
> > +
> > +                     regulators {
> > +                             s2dos05_ldo1: ldo1 {
> > +                                     regulator-active-discharge = <1>;
> > +                                     regulator-enable-ramp-delay = <12000>;
> > +                                     regulator-min-microvolt = <1500000>;
> > +                                     regulator-max-microvolt = <2000000>;
> > +                                     regulator-name = "s2dos05-ldo1";
>
> Useless name. Please use rather names from the schematics, but I guess
> you might not have them, so maybe downstream has reasonable name?

Unfortunately, downstream uses that same name.

-- 

Best regards,
Dzmitry

