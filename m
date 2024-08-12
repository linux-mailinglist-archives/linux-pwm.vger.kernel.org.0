Return-Path: <linux-pwm+bounces-3006-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D76A94E5A1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 06:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A2F1C21439
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 04:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396013BAE2;
	Mon, 12 Aug 2024 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCbGzhIV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE180C;
	Mon, 12 Aug 2024 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723435800; cv=none; b=ZHF+EepC1dZ0YbHYqim5JPmc5D7mzk52shiT8Zdhn7em8wKNalubQowQQcAC7SWFXUe+VIvDALh7N2Y2+kYnJJ9KgXDXj7lo+nhPVH9phR++8Ks4brrQhWSZ8x9mAP/dPZ9R4cMBdnAHlkgxh8sDp8sghndPXQ2Z/Sf5WAG+q7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723435800; c=relaxed/simple;
	bh=Nz13qZRMO+8sM//2Uq5O3FWReYdpqXz/N7MyKZsuhh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mi2ttIJgjCyscSRkJjTtw5h1PZooEkHTa2225Zk1mzqlwDiLrArcnglQ02SstWfdozCmdLobtD27KipQho9nTbS288NCzSPMrVwi7/Ph5ms5R1RnrQYPzGBzmAlXgRiBuKI6HWqe0l7BCafdhXmnRJyBI5HlLy/PAbSpKO7Qp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCbGzhIV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so4474547a12.2;
        Sun, 11 Aug 2024 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723435797; x=1724040597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgwBBHDKF3XyqcweRsbgYDEM8KpDwqpwsQt06/SzYk4=;
        b=kCbGzhIVnWMYQ0c7M88CSD/AQWt1vaWDy4e9cLGO/xas3vZ32dzG+BGpyko2WB/ci3
         YqaPcWgs2zKk7JB/xy5zuLugQMQidykSyOeJJ3aYwzxtebnjo/in78siTftXEyEMeveG
         eQ744ZTL28/8QxngWurh4gK7kDHb4RjP6gorIp6XxdrDxKtfTGDCFiIc553m4ad8Eoa1
         mz4nCXKG9IbaiwE/fyWiEvdRi9lzfbIs9yfECAv/v9hzPXEFfHE33V0M7HI1WKKm54uc
         Pm3P2L3RYHIxIUpCeMs5msojOj+uRSWxYF4M+sHiLILvaMlKOC/50w8GEC84aq6uBsUL
         7BUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723435797; x=1724040597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgwBBHDKF3XyqcweRsbgYDEM8KpDwqpwsQt06/SzYk4=;
        b=SLptPkyuIy1gxAEfnWpqZR7/jLzYwZDu+EC7r+CouhFD4PbWXDJ80NOIhYS+Bg4/tf
         w7kePuz6mrKpIwGYEr0TP7DJKuKcNaAqd1RI9OLdGxyOk0IFg+SVGdVI626aqiU+zjCn
         sJzyFvHc4N3+25E4W414rvNB8FQ5J0L4AuHYtI9TmOeDBC5tjoFLHhtbYz2jVHPccx9Y
         veqB0Ot8PTrvkvQcl9FQxbtZQPL/Z11SCOJZ1JH5KEzvkdJILT0MYWXBpdS9hLBo8FAm
         8Zr6rZ+jDGwGetaJiCx/olMgcVEJOXt7booDzvbNqp3hjuByQVgnJ0UmNrC/c+NY+yr9
         2RIA==
X-Forwarded-Encrypted: i=1; AJvYcCVqwcW8ezpHOF1ezS3DGseeK2LfK3QqDdGX4Ux4YDCK86ctHzGnoegscXq2UuBTcLCJZrrVeVzF41hDBpMoRXl8jrMjJxZnq6G9BX22W31tgq4IZeF9OenLzt7KAX9t2MV9MHEiQw==
X-Gm-Message-State: AOJu0YxjBBTY3JyTszDtgZApG/MI310Wyrx9LejBWuelJJ4zak9TElwO
	RQnG77JdY+5iUFgUXtY16nGfdX2hLw7i8+XU5fyBsgWIQrIlZROFV0EJKQgYmDGLsC1Tk2xDBWV
	MZLq6cYKMr76s9LlMJiupCQ69s1c=
X-Google-Smtp-Source: AGHT+IGlOC34jE6ub2+SaPQP8dRnvG7v/0QziQXHtGbrcOv3t3sWovaoNXJZIcTOySlnoSpUPZBWkSa+HbIpe475f+k=
X-Received: by 2002:a17:907:e6de:b0:a7a:8e98:890d with SMTP id
 a640c23a62f3a-a80aa594fa0mr646057466b.16.1723435796323; Sun, 11 Aug 2024
 21:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720516327.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1720516327.git.zhoubinbin@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 12 Aug 2024 10:09:43 +0600
Message-ID: <CAMpQs4LntAd4358QBSSC-xHOOyhVa_jLrTGk0-ppa9oyPgdWSg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] pwm: Introduce pwm driver for the Loongson family chips
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:04=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
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
> V5:
> patch (2/2):
>  - Rebase on pwm/for-next;
>  - Test with PWM_DEBUG enabled;
>  - Rewrote pwm_loongson_apply() and adjusted the order of pwm status and
>    polarity to avoid test failure;
>  - Added DIV64_U64_ROUND_UP in pwm_loongson_get_state() to avoid
>    precision loss and to avoid test failures.
>
> Link to V4:
> https://lore.kernel.org/all/cover.1716795485.git.zhoubinbin@loongson.cn/

Hi Uwe:

Sorry to interrupt.
I have tested the patchset on the pwm-next
branch(861a4272660ac0ff51aa4e2dbfbc3276c06b35eb) with PWM_DEBUG
enabled.
Please review it for me at your leisure.

Thanks.
Binbin
>
> V4:
> patch (2/2):
>  - Rebase on pwm/for-next;
>  - Addressed Uwe's review comments:
>    - Make use of devm_pwmchip_alloc() function;
>    - Add Limitations description;
>    - Add LOONGSON_ prefix for Loongson pwm register defines;
>    - Keep regs written only once;
>    - Rewrite duty/period calculation;
>    - Add dev_err_probe() in .probe();
>    - Fix some code style.
>
> Link to V3:
> https://lore.kernel.org/linux-pwm/cover.1713164810.git.zhoubinbin@loongso=
n.cn/
>
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
>  drivers/pwm/Kconfig                           |  12 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-loongson.c                    | 285 ++++++++++++++++++
>  5 files changed, 371 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-p=
wm.yaml
>  create mode 100644 drivers/pwm/pwm-loongson.c
>
> --
> 2.43.5
>

