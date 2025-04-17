Return-Path: <linux-pwm+bounces-5556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD67FA91C2D
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76C519E51C2
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5C2475DD;
	Thu, 17 Apr 2025 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2/hYdwk0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34082472BD
	for <linux-pwm@vger.kernel.org>; Thu, 17 Apr 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892859; cv=none; b=qVj/YXYHR5jULatRiAC3q0g+XsBI/1jv6wLbGuIu0LciMt+HCsuutwcCdPyj3LionQ+wSB1tll+kV5XyH8v1tgD9RLaC6WQcRU2b5z/G1LpVM2CRcMbgkInoFDjPk1z+3W7Xn/Tr1hlED8kHRVFk1p2dkf6WgGqccs+vEKkEl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892859; c=relaxed/simple;
	bh=9NKg6PS7oD/l+zfSC+Xp+QqcvMbLijtqCOUIAHZF8ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItQb6U/LlqrcVMyMmyHsiy1h1enVxjFItGYDEzlPQ1VfXushvHvPZa2KmeXLX51YDVzOlps7zV7E8gMAtRy9tYTcqi7MMK0nBnXnc0KY9U3kB6Cd8XzmArCwC6KchBwpP+b37dXnyE+2A5o3qRs4aHTNmLSqa8BE/FDQ5bicOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2/hYdwk0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54298ec925bso179808e87.3
        for <linux-pwm@vger.kernel.org>; Thu, 17 Apr 2025 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744892856; x=1745497656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NKg6PS7oD/l+zfSC+Xp+QqcvMbLijtqCOUIAHZF8ag=;
        b=2/hYdwk066sFzbJoWkU7fPCmiAsbGnXUyXX4svRtryx42BJvDJrFASJtpqRp80Aee5
         2QWIn8bQ0CUCthx4uXORtxqU8hyPskopHTMUnunAEgzsuZAGIM2GwAWIw8fBLLgJS3hr
         o3qkomxXBWAs+LDZkSf5Y4r3NvFuIOo+VVbOMDpgNfExqq0LWNPzCWuBiInnvQnetxUN
         yDNRjJiOMLr10PotQ0/s8KUVPeoAryT6LJowmMFAktMn3u9bfRrUVkVlzzOD5L9ViTQA
         Uqsb3C22n4qJkKVEt8bOWtj8YEZ4kGPIrPAvYcsesxV9WpXXu3nwNcTXCZSYIlNurytK
         n2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892856; x=1745497656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NKg6PS7oD/l+zfSC+Xp+QqcvMbLijtqCOUIAHZF8ag=;
        b=RP7waC4h8U8BqAt/3Di/qCIkxTktzdjdN8/RSoKt12uAq+B3JMkAW7QWc7Vxham+v3
         3Sy8LrFfhFKBUwzQYNQ+XQXbOYfrnpLNYu4bhFRyWJjOklWyZ9Rd2erLAgKzBrz8q/u9
         6c54ghh0iLHP3+JgoGKg7x5wE1bmVYqSi8895ooax9Bb97iBgTQYtTitDyb1B99ESm/Y
         /7Zol8abNWQR9dps8MPOX8tsKvbA9D39Efi3IC6tWc7lmaWPju9WPLiITMBy0OcshWar
         bHjGepXHXLVxpHT983vlijrI7Or4RYBZRUdnA01+8WkwI1YF3iG2G6ZpDkrvbqNYNpYo
         E/gg==
X-Forwarded-Encrypted: i=1; AJvYcCWqfEDQC0mWNSIukVYnXSfw7o6BJ0jUln5Xz/KMfJPXrQeuhVJScK9VvyN37F4HiC3ubZifbIB+8T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHat3eFJyD7ezSf4GTRXBP1mDcCSJeL6BqbjYeRPmJaUg5/Jsw
	CJJY3A7j41bHTxLaMqvzplSHzXnTbTGxLd5BBEakuf0TbWMSd6B0JEFjuxODfJAqxXMTLxdV80L
	nzjjMnHim8SYWI1sA8zFjhGpOjb5pmtY2IoXK1A==
X-Gm-Gg: ASbGncuPekWakGwI1FFHFUFfx7JH7d8CYFP5WZRYbBrmu0OkqKmGy6PZ4+jRHCfWKUv
	OrVAFf4PQ+6JKuSZ1EJ3O7aYsZPy2s5Pigs3dho7EpurEE9X+gLzXxaWnc80SK4X+F2tBYmEg2V
	SsDVixITwyll56kpoD9ifcSUoebrr0dseEQw38jWx3OfdhiBByfvJ8bGU=
X-Google-Smtp-Source: AGHT+IFZOoiDU7kWs1X+sCTpWHGvxIIvcjIqTCA600Miin8QaMSdk6AXbYYAHuEwzc6M8mK/9c6pIQAEL2l9q3UmHjk=
X-Received: by 2002:a05:6512:3f1a:b0:549:4b8c:a118 with SMTP id
 2adb3069b0e04-54d64a9d245mr1726654e87.17.1744892856029; Thu, 17 Apr 2025
 05:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com> <20250415-dev-adp5589-fw-v2-7-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-7-3a799c3ed812@analog.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Apr 2025 14:27:25 +0200
X-Gm-Features: ATxdqUEPbSWIENGhz4BdzfBTUTk6pTZQZuEjOvtQcIyKmHMmtvyGYWdKsEknmBI
Message-ID: <CAMRc=MedvDwXVXPWRR+6xh+LpVsZ5a_Ja5ANoJWRYNYiASZ+LA@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] gpio: adp5585: add support for the ad5589 expander
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:49=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Support the adp5589 I/O expander which supports up to 19 pins. We need
> to add a chip_info based struct since accessing register "banks"
> and "bits" differs between devices.
>
> Also some register addresses are different.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

