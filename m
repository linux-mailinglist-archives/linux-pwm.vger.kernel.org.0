Return-Path: <linux-pwm+bounces-2477-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23333909853
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Jun 2024 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC91F21CA0
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Jun 2024 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4521E867;
	Sat, 15 Jun 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjx6HHiN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA8D53B;
	Sat, 15 Jun 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718454714; cv=none; b=kbROH5tqWHM+5FEy37/GQETqIWnz9r9hyznGZm2H1AIEsHk5SUZJzZV+XG6s3ugTcXv1yI65CRbC1PRTppPW34aZs4A/uIGoAfpWP8cRjX1xSn9WpN+nswAkN8MFqI8iVVSuF5auE9xwFhRXak9Lrmco0dgPunzeo5VpBFOxyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718454714; c=relaxed/simple;
	bh=ChOsz5Prpt2kmPetgz63MyP/4cgSlQ4sFxq+D3hI9O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uw9H9Ez7djPOjZKx3rlRSCw7cpN/I0sN3qVSuIN4K43e0FBCm7gJ9Kq9X6EGCfSlej3khTF6DB8rA1Rjqg1F5nuUemA+Ch7K09B3jJs2gZAnshxln50MsnfWKi3njdalVYCCMe+S81p4VUISX3UONxxtUbVXp8TDHnI2qgyJGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjx6HHiN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-630640c1e14so37675267b3.1;
        Sat, 15 Jun 2024 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718454712; x=1719059512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J36wE6b4n7qYMEp0NDKveqjJUdZ2UEb0nYa/HH/nTM=;
        b=gjx6HHiNgex9ePAPci9eYlGdiKuc+NjuVeWxatKi6LA7gxDQ49AhdijKkzPFhQFrwa
         nNWm4eDehJc8twULM9TSBwlbBjVxSjqpCrvcuFUdDO80dtOrINc2e4CXV6RTRCJyv5vd
         wglyYZH6ecSYab3ncZ9YNzbUiqqou4AzM7KfoZoFKs3a7yMX2PczpJwAjMFR6Dsz8b52
         HeU1kzKUVl6YPy1xERhp3HfqzYaxpy2VHmGoQuAeLBOqEuXH67XI46kBELAWYyUR3yvg
         icmMeEdxIBEMj4E6EYvuARoHCaxW3rnmq+ERVxAcRaipWPorXpUPNDGVnkAaKGJH3yKT
         rNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718454712; x=1719059512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J36wE6b4n7qYMEp0NDKveqjJUdZ2UEb0nYa/HH/nTM=;
        b=Va8kRCE2anvyAPZz0Fq3gmp3u5vjYWGHH1tNzwS15sAdf+3MMtyWJRQC0mzcjZKJlb
         Ardx41anNS0cLLjjoQUOUQGvuGMKb2uWw1tw+vkBROHHUvkbDYvRIEyRuLFkkdN+uUwp
         x8x5K8LAz1oXop5Bc8wWlqDgtAjGnFPee9/8gPMuI1fB7jPVtJnCer0YuKkwAXD8IlNX
         rFBVna27R7dmftgXclh++XiJx6tnmil+7ZHQtbUQaB7WtfO+U14V9eNfbGPcPlhU7UtS
         3Td9CcioOEKr/w7nFpdK8t6dbYBm9MWGnEjwP3G9yUZq5/P6YlwPZey0bSnjJi1r5Qgz
         5+WA==
X-Forwarded-Encrypted: i=1; AJvYcCW9MboJv4fBvqUn4j5WF1zYx2BfEKXdX8lt7jGko/Kd/3jmBaLiPmdbm14Rgo7hZzXHHwjxTOXkqgWkHaX/FelcTBoDo3kUgkBQyFoS19WC14B21P/C/2RUFSgiJOzYMHP+l3roqw==
X-Gm-Message-State: AOJu0YxUzl+Qb8Nw3jwRXmO4QN08BVXFsA26LpyM9NotYGPcuLYowGqY
	0uhZFCoq47Fs9thlQKI9QAc/F7PBSj4wwC8qnPowv/DfZPD2W9U5FUKKpKjpx0q/ZpNCARiTtGc
	Y8i4jCYn1OovkGISSoq+Lo8obj8o=
X-Google-Smtp-Source: AGHT+IEc9Vgb7cAlh15eM+4S5w50+0KC+qZwBciCyJ4XzMPGsUAxR/DiAHijKkveG5RTC5/yj3a28JH1VolMn34rsrY=
X-Received: by 2002:a0d:f703:0:b0:61b:9369:ef37 with SMTP id
 00721157ae682-6322441a7b7mr46690077b3.46.1718454712215; Sat, 15 Jun 2024
 05:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716795485.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1716795485.git.zhoubinbin@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Sat, 15 Jun 2024 20:31:41 +0800
Message-ID: <CAMpQs4L=JV_tSQN_LgcwzAUjKvQ-vt8zcJO9OaKQha6zCztw6w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pwm: Introduce pwm driver for the Loongson family chips
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Hi Uwe:

Gentle ping.
I seem to have addressed your review comments for the v3 patchset,
please review it when you have time.

Thanks.
Binbin
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

