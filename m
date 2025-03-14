Return-Path: <linux-pwm+bounces-5189-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A2AA60F5A
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCD16924E
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9AF1FCFD4;
	Fri, 14 Mar 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ts5UoW2Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2191FCFC5
	for <linux-pwm@vger.kernel.org>; Fri, 14 Mar 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949639; cv=none; b=ZjC02orMQN1Xw3VEKQM7VlBHZm9Ortp8bQmKzlntNSRUamy4QKE30I/gUT27MySXs2787Unehl0SoZ9QICJl4uwktC3lqNsCaVEw3/AtB8mYLsVpTdX85s//PvO5lww5ROCxEavKxDxQoXLlVRj/vVUIOCIQQnEpAt+aj4lXdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949639; c=relaxed/simple;
	bh=TdjrUj2ENKDpO8QMmgpWcHwmqWwffwTY4fDD4PrBuM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEI7XLc3x5+wW5FJDAyHDBgi3/3xm9YRnasztFPvd30kVdYytny8R199+fZP4WrGhrFUXO/ykcluPTY+FtVRlwE7ZiCg28Yy/dvCzFQViwJXYtB5YqfNb2SddDpSb0S04JtlCUjf0ViqUdEE2sng/oFMF9KmA/KUIdrMOCWnQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ts5UoW2Q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-549b159c84cso1943995e87.3
        for <linux-pwm@vger.kernel.org>; Fri, 14 Mar 2025 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741949634; x=1742554434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdjrUj2ENKDpO8QMmgpWcHwmqWwffwTY4fDD4PrBuM8=;
        b=ts5UoW2QyXh5vBfN5rcptPygxva1UOMQcvJJl3YF7SN3js9KkNVcC5CSs2I4yR5WEC
         nkWFW6y354+sOI5aep1y+kapzuDq1dPCA3Vp/Rt1kd9ckl62vom5aWk8c1J9yvxHvPo6
         /+6M1EgwyUiDAQhDFGBW7tDzrrJVPmuky6/4T1ecyG9tmk4MGyzuUgYr6S+urcCBLny5
         Umh60qOF0XoRFlEtUjaMY1MFLsaT5BEbeuuQlF4zmzpkCaSNKFKFdUENhS/woA27wdPb
         zKyquqR4IZwQh2Xwglpa8p3SX52ZHbk5x9+nz3JIpRtmL9TDVo/JU8hIPpkEsoRmtHsb
         r6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949634; x=1742554434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdjrUj2ENKDpO8QMmgpWcHwmqWwffwTY4fDD4PrBuM8=;
        b=gHae/QOzpWsCyw4ye+xuQfEuugMMXEW43uYY2sUyocjjiI6TlkxjDIJxExz8DkY5Ts
         UzgW0vEkKS1KxYXIMGeWcoV4wv2IwyBeywq2CUYTSBs5VTNvY0BGNJcwggLYXYmOn1Se
         i4f/x4iTRe7zSNxLv3ioKtZZDM6yYzhw/CakmgVtUsAW+a4FeUnm+73P/9bHK53QH6qD
         HKP1FrjS90aVVKAxIO8AvgNmiwtpncLTpgN5hGyuCORWhuTrOnO8cP+9uFtarVvfSV4L
         fhor7DrLrp4NAV3R3+48poWk5UuLzWr6Z+TCT2ldZO7GTpQeF7lp7L2cDWRizLutl+yM
         W7YA==
X-Forwarded-Encrypted: i=1; AJvYcCWJiiborAp2hIcIpidsEDdcbhEA4DnQjExxZ1uLF1Omxj11wbhFk4qlkp6LX9o2UEfqlxicoJXg63Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKriL1NDsKjBbiTqskdKeLGGOgEdWObzVxzH/bw47E6k0TVwAD
	31bhiz/yr093xaqsvQw73JNybSIfupzYmKBdmC1LCVo3gul7sxEAKmOCFJgz8dzsSjeyAb/anOf
	/97vca4QZn5+ANN1ON1TjjbmCGenE5vKyWm0TMQ==
X-Gm-Gg: ASbGncu2prWj2GoE5tk3pEkAgHKwn+Kyp7TQrM5RnYYSWH5RTUT+W1MG4qOSgxqEOa5
	tdGZeSD0xStD7svrGnt1YEoKSeOIthk3iF/mNWwCJjma4gps5Yuh32P3/lB3z5sqzs66IOZern3
	tLTNZuHykeCZw1tUc4RzECNRMvCBIXjB73dA==
X-Google-Smtp-Source: AGHT+IGyZcjGQVRXdmPf+HFRkYlkCyfk9cxA0ikymLJVaBdq4csHhKzWdrWNXA3EtIAdbabIZKVRbXn3G++rpQeYfIs=
X-Received: by 2002:a05:6512:2350:b0:545:2b24:c714 with SMTP id
 2adb3069b0e04-549c3911e6bmr776230e87.18.1741949634058; Fri, 14 Mar 2025
 03:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com> <20250313-dev-adp5589-fw-v1-7-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-7-20e80d4bd4ea@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:53:42 +0100
X-Gm-Features: AQ5f1Jos35lQGGapvP68CdJghmgF62TRmPj48uDq9_6LrGBWABanTI3P7iIbNwU
Message-ID: <CACRpkdZd1b-D76n2oYMwg79BewV70FGaNcxbYfq1GDGOHm_BDQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] gpio: adp5585: add support for the ad5589 expander
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:19=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Support the adp5589 I/O expander which supports up to 19 pins. We need
> to add a chip_info based struct since accessing register "banks"
> and "bits" differs between devices.
>
> Also some register addresses are different.
>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

