Return-Path: <linux-pwm+bounces-6710-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB0AF6D0C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 10:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D59C7AA156
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FE2D0C94;
	Thu,  3 Jul 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qBUXl54i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D92C1585
	for <linux-pwm@vger.kernel.org>; Thu,  3 Jul 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531768; cv=none; b=GDeVPLKr9jJf7Q0OYs+lkMDzZNzraYQUSttTiziWP+P7KJ055EPpp3J3QEJ+XUnctoAyhr4rBAMkJQ9cBfQUk5/QDaHmTmo69AK/BzazeRs0koNqPMwNz3YM0+PI9isq3EQuI590oJguqAfNmHY2GPRLhnRf5QMXs2agHwHpQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531768; c=relaxed/simple;
	bh=yCgvEF3BXwg254BL3VuI6mSXhUcwMOdng9eK89uzkVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcCwDWvKF+Ms5YZK9SFTqEPF5x51NvRVDLiX/sSxs1vLkqCcn/A73cEg8CoJQqjN4faL128XNQ1Tv9bRRvztsiIoeSGmjx502Ik0Wqw1zOPl3pLMbP88L50/WMaHI2V9QjTI9piOF9Eb+7Rboooh6dLdHjUSr7M1LF2ax8wQsMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qBUXl54i; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b6a349ccso6082770e87.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Jul 2025 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751531765; x=1752136565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNAqI6qp9DPwgHXIMziYUYhWIJDnhFlRLmGxn/xudMY=;
        b=qBUXl54ibB/dGWkpR/I2WyS/E15jfFW79yGc6qa1VmQ3AXeaYC0ro6eYqlzjVFCN68
         3czFxQqGStMCmtbWwNrtAE6XiG4jWfN/uyCoVKVJGJlknAkVyvwkKGTn0+x5XZK0uD0N
         HsBDaEDl6UT0iiSS7ZP6AVpcuVbXb29uS7qYanZ0oLG/K1D0hLIgQzzUcdCq/8i3Prmz
         sb7MECuu63Hn+KGEV2vC+paqfoPr+Dpl4IIwEY7NjKnyX3/04cfE6SvqY/+ER4Fe0DEZ
         7dzH5Wz6MhsuVv/I4hhjcSigYCrccvwagc6rJe08KB0LuHqmVRyJlB5WbZpXdbv6W7Tc
         2Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531765; x=1752136565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNAqI6qp9DPwgHXIMziYUYhWIJDnhFlRLmGxn/xudMY=;
        b=iskc3pmLpg9FUGp8Pjp+ArM+IOjxTc2VznJ+YTAZi4BUXOgf11Ek8XHC1ZyYo5ptEa
         Ym/pmPxd7ds29XWkfJ3NsjR2aSpVoc2z9LaKYB99ltHfwuqGBRG0Li+BEFWub40XTidL
         yGjN/RQBh6AylSQ/8oxkHCl0SwR9d70ZFd7CGEVTdDRe5Kfs1dCciS1H9O02QHtM8NiW
         TN05apkndcPbpHqJAfNf65MFXe1Q9v6OMET3azPuJacV00wUYnof/6g9tliMyoyrFR5F
         qToAg4f2/u9X5vrn/711/pAke3EDio3Oxa0IafXFLQmMrWCftsDTZWND063exn9yltSo
         zPzw==
X-Forwarded-Encrypted: i=1; AJvYcCVbkbkTP3Nb2S+QRBfL8afc3D2AKHRs6GoDOyMaf2ZCx3tDFSiaSmFBmjFO/O4GUeS0G+x6BTRJvJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9GRpYrZAsj2Mfh76eq1HqlgE4nBZfhBgy2mTYL4WCPgRY3K/
	UNdc+q+V4o6dMX4Oi6bsIkvIGQlc9pIjgA9NPuOxuG+9V3Cg11JuthZoriVA/+bJYMBuxDJVUb5
	MIsv9h9X/AtqLsdazdt9qFMtd1eA7aUx4t9HF/nARHg==
X-Gm-Gg: ASbGncvkxSNVqmLlHtKU9POkF++1Mj5vdCCK3YUMI5egTra9Ih/x3EMZPSxhjfAD9ck
	n7aw5GmCiCXT4DM83vPXQyQ5h0VPYWFsK8WR+I9L47+NFzfnytCsxD09Fs0L8cr+DH2arIaW60b
	R0oYTrgWkgwMjxX2SBKwpmZsjuiyd1j/L81NfG/VNXnCE9H/DnMfRW6sUtqdCfpp5jEt59PHmyG
	w==
X-Google-Smtp-Source: AGHT+IEuPyZAYFCdmQ89V9IkFw3Ed/mlCz+VFY/HSyYfKRFKouDT5YAQiOyUj8RrcRrwDGza8mWYWDjfTyIwVp4+DXE=
X-Received: by 2002:a05:6512:3994:b0:553:341f:12a3 with SMTP id
 2adb3069b0e04-5562ef9a6c8mr676826e87.39.1751531764763; Thu, 03 Jul 2025
 01:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com> <20250702133609.GQ10134@google.com>
In-Reply-To: <20250702133609.GQ10134@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Jul 2025 10:35:53 +0200
X-Gm-Features: Ac12FXxFfJbvdzw57rmctFgHkWKx-gv4baKpEMbXxjF0v8UThJiEjLVfc7FisWs
Message-ID: <CAMRc=MfSeJrAatC-42upkH5iWYxuNvR26ZfHS=1v+XewspGnJg@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO, Input and PWM due
 for the v6.17 merge window
To: Lee Jones <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 3:36=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> Enjoy!
>
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:
>
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-i=
nput-pwm-v6.17
>
> for you to fetch changes up to 45ee66c37f9bd8cff7718c70d84e0291d385a093:
>
>   mfd: adp5585: Add support for a reset pin (2025-07-01 21:50:51 +0100)
>
> ----------------------------------------------------------------

Thanks, pulled.

Bartosz

