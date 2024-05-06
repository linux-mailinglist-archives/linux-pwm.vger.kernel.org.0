Return-Path: <linux-pwm+bounces-2158-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784568BCB98
	for <lists+linux-pwm@lfdr.de>; Mon,  6 May 2024 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF862848AF
	for <lists+linux-pwm@lfdr.de>; Mon,  6 May 2024 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877A14265A;
	Mon,  6 May 2024 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Px6qogDZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AC13FD93
	for <linux-pwm@vger.kernel.org>; Mon,  6 May 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989955; cv=none; b=l1ECEkLMxdUdYXeklB8ZIhvTrkLfSZP+KpI+MADv96Vurk10kQ7h6P/bEZ+3aTZsmZfXdEa3ozEtrp7zb2lLqnmJ8JFBU3NWmghzXS2/dAbyo1k9IIvbxhhjpIIIAfvQ5WpGZEwlNPJhKdiog3Hx3sDU/dfM+sSumOhQj8i4ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989955; c=relaxed/simple;
	bh=EHVAhxJUUskPmEprZXUYYP2CVf27DfLU1+UviOggadA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kji1trTn42oUQeYz7RkCZa7ULoVZYbBr/j5KAUmdFxAwNWqeQxkTEIi7TZn6QqPoW71Kwcf8gWVBrczqxKRnFM55EPFGBx7MoUAuL1YVfGeZ7Qt1AYiyX1fFLvhfrIQBZ27jwh/KTRSR45s0dPI5dERLNdmHGHvSXycPynErOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Px6qogDZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b346712919so1298276a91.2
        for <linux-pwm@vger.kernel.org>; Mon, 06 May 2024 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714989952; x=1715594752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EHVAhxJUUskPmEprZXUYYP2CVf27DfLU1+UviOggadA=;
        b=Px6qogDZ74sIj76MnfPZEftB4i9CXxmbjl5Kai4YZc0EMZ4ZUlAY5NJdzZp1qpscCF
         DcAPfjSdBXEhfXaoCNBktYMzY1NPjvitKd2f5K1EHu69a4qF/x24gueo/qRT6mZQm4Mx
         g/3Im7IWCRo6YRR2RbYaLf9XhiYDE1b2kKqM9xu7RI5bGMLIYcnWO0Tt2jr5oLJsDl80
         gtrBQjHBliIE6b2vh7dNvngGrTX4NfbiaBzmfx+o0aK2TLi5XhuSgf4zB9UkNiV1u8QY
         UlqKXtsgHcaCHsCGP9C0a9D858+mTnh6FMZ855pdZdfK9VuMAgykIfjYpa+YUFHN3Rt0
         rsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989952; x=1715594752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHVAhxJUUskPmEprZXUYYP2CVf27DfLU1+UviOggadA=;
        b=DxahdINQ7rHLeIOyvB/ZS0JGG13vVCFmmB2sG5DeeVTzmvRL2iGfW2TwOCdYqQiipg
         hnu1CRjS1OBDgoiRkmZ32XCFlzuyIvEMLB+NwmVw35TKhNHZQ1jljgO0MXbSiWRkJFak
         4HkRo4MOaB7hKcEw3b9FkqM5Q3TYLHGi5vUkbcXgZrf0aFudHpPo93SN/ezKCha6kqpu
         7CEY+Z44tVKd77A/MLmIeHmxauPaOiANVZNWD1N+KSchzuNd99pOq93/Cnu7fafw2Usf
         qHsss++z8gUBdcbrr7fAToDevBtVPxTU7aIKWA3q4nzbPofgy+wCnTqzlP5KOXkKbH20
         tS2g==
X-Forwarded-Encrypted: i=1; AJvYcCWBTiJLt8hsUp9m+opGc9LGOA3aYLeYM6def34TdPnBkw5V2AVtHBdkcPTQTTYwZgcPa6lU/VaN5wX8/C8uSEgf08Cb5To19m0o
X-Gm-Message-State: AOJu0Yyf5ILc12+vQtB/Q/SbNPgKpDEUCCUV1ioxIlk3ZtAxIGtTOzJR
	I6+kZS2peZ3R0cuUtUjDghZIIIKasX9zUS/Xl0FzWPDO8zCi77VUDqyOaPLA2laeU6CfEZiS3bT
	rqysyRVEpHY/mQPKUPc82lBMY8wynLAxQLluZfQ==
X-Google-Smtp-Source: AGHT+IGzw4nooSD+qK1cXQQ4lfrb6udoqefgbhSIEUdE+dY70rCPEtAtCshhxq/u9d9ODfZCzLMX/bw/b0jv3tpzoxE=
X-Received: by 2002:a17:90a:c505:b0:2b4:36d7:b6b5 with SMTP id
 k5-20020a17090ac50500b002b436d7b6b5mr8376894pjt.34.1714989951948; Mon, 06 May
 2024 03:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-2-naresh.solanki@9elements.com> <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
 <CABqG17hebvkpvxwGVfp0nT_YMrvgdkEqU2_XjijCpdtgU6C+1A@mail.gmail.com> <1294114a-4509-4c8a-a0a2-39f6e5f83227@roeck-us.net>
In-Reply-To: <1294114a-4509-4c8a-a0a2-39f6e5f83227@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 6 May 2024 15:35:40 +0530
Message-ID: <CABqG17hamhz9+bZ44FNkoSU5MxHLB13OZWGgzhr6xdDjdb=2xg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+Rob Herring

Hi Guenter,


On Mon, 22 Apr 2024 at 18:07, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/22/24 03:39, Naresh Solanki wrote:
> > Hi Guenter,
> >
> > On Wed, 17 Apr 2024 at 02:52, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Tue, Apr 16, 2024 at 10:47:15PM +0530, Naresh Solanki wrote:
> >>> Utilise pwm subsystem for fan pwm handling
> >>>
> >>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> >>
> >> That adds a lot of complexity to the driver. I am missing the benefits.
> >> You are supposed to explain why you are making changes, not just that
> >> you are making them.
> >>
> >> Why are you making those changes ?
> > Sure.
> > This is to align with fan-common.yml wherein chip pwm is exposed.
> > I'll update commit message
> >
>
> Adding lots of complexity to a driver just to have it match a yaml file ?
> I'll want to see a use case. Explain why you need the pwm exposed.
> "because the yaml file demands it" is not a use case.
The idea behind this was that this approach provides flexibility with
hardware routing i.e., PWM0 might be connected to Fan1 & vise
versa instead of assuming 1:1 mapping.

Regards,
Naresh
>
> Guenter
>

