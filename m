Return-Path: <linux-pwm+bounces-2616-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884691803D
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13412281160
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3617FACE;
	Wed, 26 Jun 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/K3zpan"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CB16A94A
	for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402740; cv=none; b=dj5KZDF6L9S7qWy9c57h0ewEFwLVgEXSyFU1NtPnGPm8KLr6Ezym8u/CsCHCdntSJBA3IezC+mvCzLHN7DBSRC8qQKdhjDC9H9cOX71AWOWfWzMC6EQgCN3w1DyiV3qI1xDprX2MQdtUem/CgAW5lRchawzNZJk0KCgF1ongFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402740; c=relaxed/simple;
	bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfzF+Z3puomKlPYHkH17e4zopAQ567PmzNThR9gZQapxpr040D6emeQ+7kWrlhvus/1RUWWpwv22+JYRju8RVxM6MQ6trB8ANs+RCf1mQTYubADtdGVILz1wpoU8Hj9gAIHRX06LhVfavHEUxgw9XF15CtLVN97tg6mY6ODeMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/K3zpan; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so4777983e87.2
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719402737; x=1720007537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=n/K3zpanWGKqPhLK59mSDivOMI1MC2+Qos/dqLjhqOsz7xGe7hr8nScuL9i3G/V/Vb
         ULG76D40rp5OZmWsmzZfZ3M6wS81Fcrkh4xXXqGB5XJ5ofDgSaP/SzFnjLsYl5C3CAiI
         EBLShuGW9uIoSFHQg1be8jg0qauh7B38uqcU4W7rEUeJbUtSVuaHrc+1zIVDNxgYSgqW
         63Ng9xsZXdasff1r5iIjywsn/0blwRidzLKpWrs1qlTwV7mzWgTXCKBmd01cLPkfhlmG
         RD+MiPy3jrewQppmRI8yIDHGUyTcjd2We0vyLOlDQsv8WcIw9pPcLZRQVG/wjEHF8jzh
         Dfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402737; x=1720007537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=HNQ7tg/hV5jxYxKkzU5JKL1nob3g4gVAg94U9Zh5JgmX5SiWD/xRUddvaLMGrzR8+O
         XXzXysQ0Q6OAwv0ALwiixBijRcoPcr6/dUvWaewyT0Lbo0Kz31qktwvXMgZC3h/PQVyp
         uYVPBSXv0iG0+7+HtbsSLcnSV/4PWVf+VRoIZtqhuKrMlTnRx7iDrQFwItC5aOXQj+QE
         JSSljlqT6H8SDN4GwhvHLbOFgZiH+hcBED57iadbK6piUl8Y6oD1YXJ3VYxm6VJypU8V
         NfZbgH5m4s/qRClxvg6Gdu6y99UaDL0DEoq3DOYChzQIsPloLLzfh5Y7zoOum9iKvqOU
         BqNg==
X-Forwarded-Encrypted: i=1; AJvYcCV12mBpH5SoEmD+6AiSJ0cbpVQJlPVXvmik48JARkuqBRlexjoO4033FNYreS4FQhgSL/JCqknBAuF+WmlhAxS7f0fcqY0RU1Yq
X-Gm-Message-State: AOJu0YwTNd+1x70bHVT1Ku4GUIHUjgvcu9Q6GB5F7LxZWySz4bCMi8K5
	mw9W2c/03WfO9YzcS95fyzo3DISoo9O/rAn+mbJqsTJ0J4NZDK0gcPjX4wXbpttmAXAoeQ/HnS9
	3ZTO1GXnLzWrRs2isSYTYh8gxF3FT+Y4tGIo5/g==
X-Google-Smtp-Source: AGHT+IFt5Y6rNkv7qP0DY/jJs8uCxG3fud41/0H3+Siz9GLV1bZC8qZKtVnvB2O2VW30MKoOlKv1yDATTfc64MFALP0=
X-Received: by 2002:ac2:4e09:0:b0:52c:d80e:55a5 with SMTP id
 2adb3069b0e04-52ce183aa97mr7510215e87.41.1719402737078; Wed, 26 Jun 2024
 04:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624152033.25016-1-tzimmermann@suse.de> <20240624152033.25016-6-tzimmermann@suse.de>
In-Reply-To: <20240624152033.25016-6-tzimmermann@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 13:52:05 +0200
Message-ID: <CACRpkdb9CNMw1z8q6gQb0Pi6fZhOfXCoiM1s5QdszRqgbxa+Lw@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] backlight: gpio-backlight: Use backlight power constants
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, sam@ravnborg.org, 
	jingoohan1@gmail.com, deller@gmx.de, f.suligoi@asem.it, ukleinek@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:20=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:

> Replace FB_BLANK_ constants with their counterparts from the
> backlight subsystem. The values are identical, so there's no
> change in functionality.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

