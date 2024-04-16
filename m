Return-Path: <linux-pwm+bounces-1944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FA8A60A0
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 04:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40365281EC4
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 02:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AC6AD31;
	Tue, 16 Apr 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrMBvdGX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18384A946;
	Tue, 16 Apr 2024 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713232984; cv=none; b=o7O7m6gYeL06vbSKeDwb/1BUxTI1NZGjFgl7/d27lddOD4d84A6rjIjjKRIt6KUidkNQSzU4AOLbggpDMSILJXxcB40gPjB0TFbHFRiFvqyYKL0fuijp2kg5DuIeX7RLfwTEdKROV3Y2eDmmvq/nFX2EOAWriGPuCveS5MJmptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713232984; c=relaxed/simple;
	bh=3WqifSbtN8TIzmVjYo0q7FTgSFMt6koRQCXwu0RxUxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZzMu7As8ThqUfNAg8/hbETBBgBl+w/XqaFrrMRspWq2WSTPrdKLQ1uFAQ4jmgVetYeirNJKOztVe+br5HUqPJMBoMZswsLIw1QKavfHhfZCkg/W8308eoTMbJm4NlgZSeQdaihp3dLebt5WkvWOH1Bh9ZJaQyFSl0wfOLg+uOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrMBvdGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9535AC4AF0C;
	Tue, 16 Apr 2024 02:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713232983;
	bh=3WqifSbtN8TIzmVjYo0q7FTgSFMt6koRQCXwu0RxUxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KrMBvdGX3qtnsTUkbsy61M1J/DgQBkHBLehQP/ZNxVkuKgA+4AE+rY23k0E5984bB
	 ooKyVK/0uXhUr6tgkoPVuQtUtMp6M6R34Nj7Wc/DlckPylg7uVbgxGh1ziLoEiw5jG
	 v44gbYk75F/o0LlYFGISP+21rNcncbOYQlBaFmjoYHVG2heemjirsVoykoZeA9AhpD
	 iZtHil2fpGvXs/F7yNnkNS98zThxIOse+vTxEsSrQzAJ9uCI8wtx2pUEMkSOiuD9ku
	 NQoC1MuBWpMTMkVveKUezzHZV3aaTg96+8OLXioth0REW3wp/cgEH//hhO6t8WIp+c
	 rVvzcrwlDNX8g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d4d80d00so4763791e87.0;
        Mon, 15 Apr 2024 19:03:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzdblPTwM4hpImr4yIvHxcT0baACws08MACE+EMxJve2tQZNtmqqQjZNksV2QZgUeobxxurcBY0bGmaUd4jDS5xPFmkkzD0CklZiIyu8ePyJuIKRXGmUJqqkA19WeGaVt9iZezSA==
X-Gm-Message-State: AOJu0Yyk/G1cUcCBj/Zq3eouxRC9e8ddCfa2XNsgNtXi/orToSYDg5+i
	tAuDmlHGaQKJmWVOQX/170CULY8X7fPFRqtf/xihfUx+pSsd4XW3D4hGu6YxiMegwoOXH60/+3u
	WI5zDZWU4OQtrRKh71yS67SsoB3g=
X-Google-Smtp-Source: AGHT+IE+pBbb2+flLNHamNgcJ6TPetBySIHq8I2RWZU+BI5eojLR2hOPtl+aTfxchzCeKtyQo6/m7n+2QtS6IyI+t3Y=
X-Received: by 2002:a19:6447:0:b0:518:6e92:c1ac with SMTP id
 b7-20020a196447000000b005186e92c1acmr7868504lfj.17.1713232981856; Mon, 15 Apr
 2024 19:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713164810.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1713164810.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 16 Apr 2024 10:02:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Y+E6Kr1Nfd_3Mvyp8nyG-_vt6oz+usteNWV5T6Tyv0g@mail.gmail.com>
Message-ID: <CAAhV-H4Y+E6Kr1Nfd_3Mvyp8nyG-_vt6oz+usteNWV5T6Tyv0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pwm: Introduce pwm driver for the Loongson family chips
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series,

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, Apr 16, 2024 at 9:55=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> This patchset introduce a generic PWM framework driver for Loongson famil=
y.
> Each PWM has one pulse width output signal and one pulse input signal to =
be measured.
>
> It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips=
.
>
> Thanks.
>
> -------
> V3:
> patch (1/2):
>  - Add Reviewed-by tag from Krzysztof, thanks.
> patch (2/2):
>  - Several code stlye adjustments, such as line breaks.
>
> Link to V2:
> https://lore.kernel.org/all/cover.1712732719.git.zhoubinbin@loongson.cn/
>
> v2:
> - Remove the dts-related patches and update dts at once after all
> relevant drivers are complete.
> patch (1/2):
>  - The dt-binding filename should match compatible, rename it as
>    loongson,ls7a-pwm.yaml;
>  - Update binding description;
>  - Add description for each pwm cell;
>  - Drop '#pwm-cells' from required, for pwm.yaml makes it required alread=
y.
>
> Link to v1:
> https://lore.kernel.org/linux-pwm/cover.1711953223.git.zhoubinbin@loongso=
n.cn/
>
> Binbin Zhou (2):
>   dt-bindings: pwm: Add Loongson PWM controller
>   pwm: Add Loongson PWM controller support
>
>  .../bindings/pwm/loongson,ls7a-pwm.yaml       |  66 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/pwm/Kconfig                           |  10 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-loongson.c                    | 298 ++++++++++++++++++
>  5 files changed, 382 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-p=
wm.yaml
>  create mode 100644 drivers/pwm/pwm-loongson.c
>
> --
> 2.43.0
>

