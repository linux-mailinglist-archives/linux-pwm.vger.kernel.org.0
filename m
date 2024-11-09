Return-Path: <linux-pwm+bounces-4049-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64B9C2C18
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA58D1C20CEE
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529D014EC4A;
	Sat,  9 Nov 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQTa6kdW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935602233B;
	Sat,  9 Nov 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731150463; cv=none; b=MocdyEZhcGhEZlqvb1Y7IVwPRqnjNrl0vr2OG+wX2V0iMo/SAp81WXbDYiy38PPdAVeKievJ+TqnZaiXrAZiM+TqsDkbdGVvvf4/kKUz5F4oujn2Sme9/ncXRi6nEEtCXaD0PbPU7TT4nxDUNaFNDnhYtg2U/s0uKuiuwxrh7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731150463; c=relaxed/simple;
	bh=QS9QXHA9aIA753MlX+rgP6S52wu6QOzrQQPQXLb4Oug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqpDCYcQ/KVvotVs/jwP8UqPRxH9c1VCAYRoy4iB9/71MnV/rEiqk3qgza/I1HM0HS9d3x+NjsXGZuTKTab/DiBtklGP1DPTT0nJss1TDVHMY1zsGJ3k8bRtP7YkkOOfx/Aaf14S7kk9UpMIytzeEwBJrGbjOJ47WQebcD8B65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQTa6kdW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso4009864a12.2;
        Sat, 09 Nov 2024 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731150460; x=1731755260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awye95iv1yEMNkGuGKMnnPe3aEgESR2qeEte2B8YfLU=;
        b=XQTa6kdWr8x+Fn1LGIemSbQE30tUal3TRYv/x/VU10t1Q1qYqnf9xoeTu9jwAb1+hX
         l1MENe9ScEsR5F329kJZqM+WWMPx1fMJv7AbKWywEztqhcaZiFSFr9ypelwKiADfDDob
         vRcI9GRNrLrmaIIF2vk8epsVHmnBBBZt6vnLASE9frBSo+nscNB9kC081d5YFLM/JgXM
         mVAtsFY4zgaolfsKaRb3rc44HmhpjPvLzRGGZ/2/opTvE12HNZP6EzjZ3KJLBgaVukkm
         sYuMP79L87EY/La+/NVPwj+cpCC2fFcmMMutT0gUICmWEJSl6JjkrdLNZEFTyIzSK1Ns
         BgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731150460; x=1731755260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awye95iv1yEMNkGuGKMnnPe3aEgESR2qeEte2B8YfLU=;
        b=wG2F2HZIZGAvpOrukOE/1FiKWjpu2Ty5jAYN2Vlro89z4eXOnohV3AxuyriCD1PFFl
         om5SDjt92pPthTiuHYQK3ujMH+cHYtUuLUnJwxpUAQ1OtvSD+jkwasHR2Bny12bws5hY
         RUQhzHaLL2jT9fSEb7bFo4uqJlHTA5hzT8GrDlaWJ2duAYP1+TD7OwhsfwoXstGY87+d
         gZhdMGBjCHSf6aCC+tzEzSx+sxBnideAvv/nhrV5MjgPQe3a8B6stGP4YzgXvSo8aaEC
         L/OFm9zz0D4QkjIF4+OqDpC4C12CM9mwxMtx240VHuRdKds/1Azl3+Ze0oV9YfddDWlN
         NSJg==
X-Forwarded-Encrypted: i=1; AJvYcCUJxZYhAx1jWXFokrHyTzMkE5wW+v7c7B2wIonYdcuFBAPq2MpOiaArkZjVxVnuGNuJ2nUhvnu4Hz2U@vger.kernel.org, AJvYcCWHp4CCM9kfb70tFPkafzxe0AGnwyl9ZHHJJxRfYairJCPtzRUl0QaYj/OT/oqe8OmzLmLKj/YZohX5@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrtr/ctTXJuu1W2hijI1SUq8R5ajpqe2sudYzAh9yTURnCU2X
	lUGl4tLWGhANPfiEKoT2bwhXMhebz3piDCarZ91qmeTWBwI07Mvg4QLNE1Leg4SL9MMX0DRHfGx
	qjBZ3MRZG9BQdgxz54tZiwI6A+Js=
X-Google-Smtp-Source: AGHT+IE7QnnwmUPJHAhpYjQ53+P2XjG8mYIekPucikrnAm6nBdhxXkmutfFnCQ+ZZUdwIEe3sKpwxcnrh3kFtMAUPPU=
X-Received: by 2002:a05:6402:40d6:b0:5cf:1b53:1bf4 with SMTP id
 4fb4d7f45d1cf-5cf1b531cfemr1676430a12.17.1731150459603; Sat, 09 Nov 2024
 03:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729583747.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1729583747.git.zhoubinbin@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Sat, 9 Nov 2024 17:07:24 +0600
Message-ID: <CAMpQs4Lv0_RjoyzJHtrekbHB+OiV5Si6yPEgp_u1ZZKkthGzhw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] pwm: Introduce pwm driver for the Loongson family chips
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Sean Young <sean@mess.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:04=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
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
> V7:
> Thanks for Sean's advice.
> patch (2/2):
>  - Set chip->atomic to keep pwm_apply_atomic() can be used with the pwm.
>  - Test with CONFIG_PWM_DEBUG and CONFIG_DEBUG_ATOMIC_SLEEP enabled.
>
> Link to V6:
> https://lore.kernel.org/all/cover.1728463622.git.zhoubinbin@loongson.cn/

Hi Uwe:

Gentle ping.
Any comments about this patchset ?

>
> V6:
> patch (2/2):
>  - Rebase on pwm/for-next;
>  - Add Reference Manual;
>  - Shortcut if !pwm->state.enabled;
>  - When state->enabled is true, unconditionally execute
>    pwm_loongson_set_polarity() to avoid that the polarity register is
>    not set correctly.
>
> Link to V5:
> https://lore.kernel.org/all/cover.1720516327.git.zhoubinbin@loongson.cn/
>
> V5:
> patch (2/2):
>  - Rebase on pwm/for-next;
>  - Test with PWM_DEBUG enabled.
>  - In pwm_loongson_apply(), the pwm state is determined before the pwm
>    polarity, avoid test failures when PWM_DEBUG is enabled;
>  - Added DIV64_U64_ROUND_UP in pwm_loongson_get_state() to avoid
>    precision loss and to avoid test failures when PWM_DEBUG is enabled.
>
> Link to V4:
> https://lore.kernel.org/all/cover.1716795485.git.zhoubinbin@loongson.cn/
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
>  drivers/pwm/pwm-loongson.c                    | 288 ++++++++++++++++++
>  5 files changed, 374 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-p=
wm.yaml
>  create mode 100644 drivers/pwm/pwm-loongson.c
>
>
> base-commit: c13bce43b32b06f2273c7961940c391cdaf13d1e
> --
> 2.43.5
>


--
Thanks.
Binbin

