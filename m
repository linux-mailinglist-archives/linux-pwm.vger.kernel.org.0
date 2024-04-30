Return-Path: <linux-pwm+bounces-2142-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148028B6BE4
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 09:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4561D1C22030
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF141740;
	Tue, 30 Apr 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+t13E2I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA5182BD;
	Tue, 30 Apr 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462410; cv=none; b=gmG75DliJjY+bRv3CBtDqveqeJqqn4a5tU9+zBcg6bRhp//WEBnkYDzUlSPes8FPEOJBLm5065aafDzJq+rSand4/n3h9r5QHtT/lr3driMg6e2pIJPQ98YHdZ0Z1kdZyvCIZWNY/wF5SURkqilPanusvHLDBGVC8TOZTiA0HzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462410; c=relaxed/simple;
	bh=r3yZQOo7p6VsIe3U4P+tg3b/ZLhUdSJ+KRIWZpHmqME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kahqbWF2DHrpO/QDCUWPDqlCx+M4cgpvyll6Cf/Ls9X95ccGubfbEAod3zDw8+yDSGZezomB1nulYNd0n2+1sAEAK+FLja70cZYcMFS7LSKGW9dBuaypBbGDyVaep92vFItaipd+ozJv3Sa/y7Wuk3Yq5P2BtCMm93jnmG+N7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+t13E2I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61bb219737dso41765427b3.2;
        Tue, 30 Apr 2024 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714462407; x=1715067207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1t1YtdVQhMuh5WLzKhqApsNSS87AIHqdVoWO4lvwyE=;
        b=G+t13E2Iy7VcLbFBUxF5iV3g0ue8vJAk0v80r0ReN+xFGA/bk0Bw2pYGWx+0cV2i0H
         9VWBbDPP21KsvUnmZPTfERw8oERZHFiRQ8H8SoqHvf5Aw04EA67NOz7J/2+nPF/g3PMm
         weWmYhM0dldEK3Rxi4xRrghPwucyy64JpXa+y1HKQ37H9TiGRRRX7fDqnFU7BBH7mPV5
         fSzR5PYFe1AckoMfoElfEvVJNQPRAmtcEXjfLc6bRxn5UxkEqcdEUCajXWfnubgSMh8T
         6iujETsTvQU8u1VoZLieCueXegMd20gArhsr6SY6AsHkwgm0Muxrh862uuOHsMykNZ0Z
         u34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714462407; x=1715067207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1t1YtdVQhMuh5WLzKhqApsNSS87AIHqdVoWO4lvwyE=;
        b=DCNSydxcthcYaymDYuFQ4Or+LMDJNCPuZqQZkS8ehNDpy/YPtNmFvZ8kVZeaHobkNT
         iwbGqU8kfAsLDnSOCXuw51UDYZewGxQh5MrTnS/TI/eFtDz7q5B1wrDOHJ3bzWSNqu4V
         SIJLPop2e6hWJqSD1bzjZY27sqx2gXSGz04978sNVNchZkDtFq42GEA4RmMD2MMLsO3R
         DvttAX6tJs/ysyRedaIlccPi8JejEvLk1UAvI6Ps374hUqkWhdAUwp9DRly+7aQ5oHqy
         GGhD+zeTKvZKnec6/GA31fOH1vAQ5ZdToVqDwquLknwyA7PB4VJBRL+KZxJLHbsQBf6Q
         PC2w==
X-Forwarded-Encrypted: i=1; AJvYcCXseW8o8MKFDKkF6L3fAt4/SObUdCdSt4OBmX7VG/prpGRPYayjfvIJwfgMp4HfDeTQGIXU/7vAszUXMUT3tn88odSxSQN6R+kx350wyokNKKZeEysgd4fcdoebMAktiYA2eJ1NCw==
X-Gm-Message-State: AOJu0Ywcswckn9678Z/AuXIdkmoF6Z7Bl6AFYyIhttZ2Cewjh2XycozD
	KbjMOK3asZD9xwq0rt34g5ZvztkTLd+jkjO2mC0W8CMKUb8LgwpAUlv9kA9VfAGk3KKeYSU9s64
	gxXbWZ4VBiKXisICA4FPXJKuwQXI=
X-Google-Smtp-Source: AGHT+IGdaXe0AdtKqsfeXw6soP40M1C7YdJ1S/7IP5X2AoM2UtipL8sYJvRDlyY2qFs1/W7AObRd05SaPuE5W/+FjBw=
X-Received: by 2002:a05:690c:d1e:b0:618:2f6d:ca80 with SMTP id
 cn30-20020a05690c0d1e00b006182f6dca80mr2400093ywb.12.1714462407621; Tue, 30
 Apr 2024 00:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713164810.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1713164810.git.zhoubinbin@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 30 Apr 2024 13:33:16 +0600
Message-ID: <CAMpQs4LD6R6TgcE_MJ4akwgtDFVA5VHh4oTSTy0bzuLxUDXWxw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pwm: Introduce pwm driver for the Loongson family chips
To: Binbin Zhou <zhoubinbin@loongson.cn>, ukleinek@kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:55=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn=
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

Hi Uwe:

Gentle ping.
The dt-binding part of the patchset looks good now, do you have any
comments on the driver part?

Thanks.
Binbin
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

