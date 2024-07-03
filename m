Return-Path: <linux-pwm+bounces-2665-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBE9254DC
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 09:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29A8B20CAB
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F133137906;
	Wed,  3 Jul 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn787ysy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA132C8E;
	Wed,  3 Jul 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992568; cv=none; b=aPBH/hSKbZJQuyec+HYnkh5F2oTwXvXzL73lYhj8UE3ekb8XmKqWblWXqVNC2iTCWSL22aDZswn0+q7nRh3/2ZWpQO7ou/OdeNqDcxlrXXyobdNlCj9sd+P/ASE+g98Ty2VdYw05Swg2TgWti9hUCzqftiHJhQ4dyi2KLw43bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992568; c=relaxed/simple;
	bh=d7wO73FMzmNUnkXQK7veItmN8OK22DyDbCyHBBaKR9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrxKZzwXzY1xijrzjvcY8k2GQE2U9Bu8CoCWKFbVBAhvDCs04kdILk8Hzo9TvFJ+IiunFzoRcOc9MYjhcj6Gb0InW4f9yWbtV54uEfPZMYS1vHpvqUrv5CiUePgflfUrUp4O6dg8E3hQTGfVzfg84e/YH2nQZRA0p9ardcPdgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sn787ysy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4460C4AF0C;
	Wed,  3 Jul 2024 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719992567;
	bh=d7wO73FMzmNUnkXQK7veItmN8OK22DyDbCyHBBaKR9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sn787ysyg+fy2gk9vd38gSTE9XZoiXdcUQ83uSUyBjhO+qJk+vUNsuIlTtRpdhuj6
	 cegwjX51eh3bpf6QFlsgIlLMcedl6y/udnkY971NlqJbLmVNOEAmQqx8BkdUtYsQ/n
	 DbYDBuoX5n/xxKbXm7PnNx1QohiHQDdXZX0zOcL1Oc+RBIvj30LfTXgGlaCzIP9tcT
	 KJGGKTmX9A4ESxexzS7JE5mnWSH4zUyQxQPpkz6QoSyJ+HtncXQ4p0HK4mRfRu38cT
	 fPPl6JrAxUGr6rn594HI/2sXbFiqmMRjJe2SNg+D8YKKHiqV0Zc1kN2m+cpnAJAtpR
	 aSEZWKV2Y4xKA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58bac81f39bso2048328a12.2;
        Wed, 03 Jul 2024 00:42:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWubQoEwI3PtfNAtXeXga0zWWV4riYnODUuYNVIvKGSJN4r2gbuqzma/VdT3oGfzkAYKDQDR7eRaFTLsXrbsUeXot5PZEwZSyKUrjEYc03anMKdAjY9aA0S8fn3zi2e88aGzWkEXw==
X-Gm-Message-State: AOJu0YzwjIXcoVtSyCYiPriPIMu9h8RAkxi2/CARbTROsUj8fNS2VKWw
	1JDi22EKQ/uo3GF/+OhPeBapXsKQUmSQDnJSyJhVfrGBEV06DudLcQGATi3qW7yXaTolcyj3F/m
	kGTa9rM3I2w47+0xd4SEvFQrVWyc=
X-Google-Smtp-Source: AGHT+IG7z1ijrDHEG8xdMvbUQ+K+sy3FSfHCIPsQRvUgfxkc+1nRLMzeAYnpn0+NqfyMLJBfczDO5uruzkeQ0HbD4hE=
X-Received: by 2002:a17:907:970e:b0:a72:6ff6:b91a with SMTP id
 a640c23a62f3a-a751447b21dmr821270266b.51.1719992566477; Wed, 03 Jul 2024
 00:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716795485.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1716795485.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Jul 2024 15:42:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H793mKPRyng6VFxS5=sXofvTAFX3t-h2MPCVs+9boe_NA@mail.gmail.com>
Message-ID: <CAAhV-H793mKPRyng6VFxS5=sXofvTAFX3t-h2MPCVs+9boe_NA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pwm: Introduce pwm driver for the Loongson family chips
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series,

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Mon, May 27, 2024 at 3:51=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
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
> V4:
> patch (2/2):
>  - Rebase on pwm/for-next;
>  - Addressed Uwe's review comments, thanks.
>    - Make use of devm_pwmchip_alloc() function;
>    - Add Limitations description;
>    - Add LOONGSON_ prefix for Loongson pwm register defines;
>    - Keep regs written only once;
>    - Rewrite duty/period calculation;
>    - Add dev_err_probe() in .probe();
>    - Put the parameters used by PM into a separate
>      structure(pwm_loongson_suspend_store);
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
>  drivers/pwm/pwm-loongson.c                    | 295 ++++++++++++++++++
>  5 files changed, 381 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-p=
wm.yaml
>  create mode 100644 drivers/pwm/pwm-loongson.c
>
> --
> 2.43.0
>
>

