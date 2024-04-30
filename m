Return-Path: <linux-pwm+bounces-2147-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B08B7E48
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 19:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6305F1C22560
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35D17BB0C;
	Tue, 30 Apr 2024 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncPzi1s3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06709179972;
	Tue, 30 Apr 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497402; cv=none; b=BVVwYWTU6xkPiU2exAxBMiOceA1OcEkYQ4/EVGwn/2onh3yJMHx8Xtzgdru0LxLcW+8KAdHKKh7n0tIvLNLpoijTJyKy1cwyokZPfSCuQr0OP931FfohSbdaebnlyEbChTGHoCENkvRZfJ/Z1UuB/AyU5Rm+FShJbA8kvVix+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497402; c=relaxed/simple;
	bh=UM4Myfw7j7uZr0oU03VjauXTrSlN9bfj7UyNwemQRfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GT3N23bhI6L289Z8cZuo+6XAeuieMuxlQ9ENk7mKhraSS1Nr/ATN4iv4jmJAKdhl/Q7R406GU8O8f8nj2AzxE6od9kqz1ZxvZAiX4gCgiChqIgktosP0E8xrQ0S9bvzUrb4kJJp3nsITGEDTo0vSOveTeyGE3kIsVk4p8A+YbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncPzi1s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C62C4AF18;
	Tue, 30 Apr 2024 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714497401;
	bh=UM4Myfw7j7uZr0oU03VjauXTrSlN9bfj7UyNwemQRfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ncPzi1s3u2ES6MKoFRNVJhpNljKB77/8yxn8ZPIRnm4709iv7dhFzNiy7FMSKvBU2
	 TuBFzDRe+TaQIX5lam6kpxda76PVYMXdMKuQhF6hait4u/NqcMQnBK+QTTONEVFo6r
	 JI4suDhDfKgWyqDtURiIAJO+e+xmpujFhOATjIBP4XvRUR9mvzP+gqnN1ltMYpyrBt
	 uY7aoUgKETyVogbB4k6UDg3sPD5gyQwYTaOM/51BGHd9lNbIsqluc283xvKyoHl8y9
	 foImlEUMJaAuaV1CweL6tu8HQ6Sv1V+tW9AsGzzeQptMVh/iJ92zUmQF9A25bkqI4z
	 dMg/+iIiGR5Vw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so7200680e87.2;
        Tue, 30 Apr 2024 10:16:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXQ/nat75G+5bqbsbRC1LDW2m3RQJLMNv5QQIIM2nS+q/uYMUqjDIBAIcMHMHRq9yX5+/RqNe7v356Ft6dOdPKh8f1kZJdf0IjbQ/P9XVn/e6RAMNnYigHK7NX7chnceIZuYSiSg==
X-Gm-Message-State: AOJu0Yyy/5YKNVQ0HCsuPkePyJQlFsa6bIBxm8bFgwoPQdiGszaUO+5V
	O+735mcl8hrjvBciaH/wHpxzBpOY3yiVS+eH0JdAZHOuZ/vDEUCJxptmMW6XZfhA+1wZE9jaQHA
	XdNIp4pUZgRUo+t3bYSaLvZJPqw==
X-Google-Smtp-Source: AGHT+IFoXSlP1BOLp331TXPZuru98nnqyG+1OHUxU2ibTvTPfsH3K6ZLAW6XSvJ7z2hH995oh9AaoeVqBKOvO/0ukAU=
X-Received: by 2002:a05:6512:2087:b0:51d:9429:dc with SMTP id
 t7-20020a056512208700b0051d942900dcmr72850lfr.5.1714497399803; Tue, 30 Apr
 2024 10:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714450308.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1714450308.git.zhoubinbin@loongson.cn>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 30 Apr 2024 12:16:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJK7MTC5LEfUnyOdpcmnON_aT4dJgpvDXAifJiYaZ_pug@mail.gmail.com>
Message-ID: <CAL_JsqJK7MTC5LEfUnyOdpcmnON_aT4dJgpvDXAifJiYaZ_pug@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] dt-bindings: pwm: Cleanup pwm-cells required twice
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 2:32=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> When I was submitting the Loongson PWM dt-binding, Rob reminded me that
> the pwm-cells property was already required in pwm.yaml and did not need
> to be repeated.
>
> This patchset attempts to clean up the required pwm-cells attribute twice=
.

Thanks for this.

> Thanks.
>
> Binbin Zhou (6):
>   dt-bindings: pwm: bcm2835: Do not require pwm-cells twice
>   dt-bindings: pwm: google,cros-ec: Do not require pwm-cells twice
>   dt-bindings: pwm: marvell,pxa: Do not require pwm-cells twice
>   dt-bindings: pwm: mediatek,mt2712: Do not require pwm-cells twice
>   dt-bindings: pwm: mediatek,pwm-disp: Do not require pwm-cells twice
>   dt-bindings: pwm: snps,dw-apb-timers: Do not require pwm-cells twice

This could really just be one patch. It's the same repeated change and
it's all going to 1 maintainer. No need to respin for that though.

Rob

