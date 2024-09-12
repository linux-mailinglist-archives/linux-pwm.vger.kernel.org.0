Return-Path: <linux-pwm+bounces-3221-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD597658A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E7C1C22F0F
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47461188A35;
	Thu, 12 Sep 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2mJ1WJQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEF18FDC8
	for <linux-pwm@vger.kernel.org>; Thu, 12 Sep 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133352; cv=none; b=m2rVEJenuUAeLnK6n2u3EyQmcdmwCZAFQa6XXLTCgBbJnb+UpCL3KEyUlHxTA5wLoW+hRFW3KAkwf1F3Iup4hw4zg+8g4FZEzgjTyJAEsMDSAoN6JLowApuE1GeW+9UpYnnkk1A1hhjYss0O0Qp+tJZEOXqqzfJYTe8oATTI6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133352; c=relaxed/simple;
	bh=f1LgvUXrqwLz/Z4q62FxAV/qtsloeO9ZWMMYuuVqxOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cLOfk6V1REys3pNk+Py9+CJR5Izk20AKrtYc+4V7K+wFiX53MQJQ7EDeOClMHo5GLGBQPkA/p2bUMFf2r0MWsizEtA4gicM6VSV3Qiou/GP4+J2fU6G41MN+DS0blEQqpbqpc7N1bX18uL58Xstfggo0VRvsWv2r4K9uZTlbckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J2mJ1WJQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso887316f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Sep 2024 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726133348; x=1726738148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp9jPxe8dbEyJ5HtUVcWqEzQO64+7gaLQ5RI1SB1IH0=;
        b=J2mJ1WJQ9XprVcRx2GseUQBCqQ5rtefft/XEVK0VtWG5AOAvfjNMBvo4eAhLnW4sBb
         oMMPE0tjNRl7nEHNVISd9a8aYcygYirJvKZmSPPZscYNdoH+Lg+yUhcaN4rZgXjh0wQ3
         n4AoqvCgs5EhmAhLW+QIlmtSieLgL9EYhcE2b5koOpmNHGdgiVSjvotVHMp4H5C98CgN
         oOIJ/1Z7bWjYEFbnjJ+riPmZbtVlraXKTu1Q5SL1LmnaBP87nLXBRg3HFW2dp2G/woET
         NuwJhXTrkcYz8+xWWe7CAjCK4hJeJmAmagAhEaSqgbFBVQUNZFbJ+iOhKgN8kX97ZIL0
         tJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133348; x=1726738148;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wp9jPxe8dbEyJ5HtUVcWqEzQO64+7gaLQ5RI1SB1IH0=;
        b=AmLtLeS5O2lGbotnk5vtC6u+x1jgpvk4AmmCAv2A8dqsYcHmsnkoKFny7XD2tsyG0Q
         j+10jeWWTu35fMJnLDA/GAzuAiHF6Olso7G26kgIkkQKTIDYz36AIBrBK7ee79HQU/Vb
         X0NQaTAiLUP6/AR36HvSk/pj/8Ykn0X8TU9k9H33vqc08orfB9lQMhpRgYcTw9D5rAp7
         WwxYaa2s7RWE/6JowH9HGDPqyZDiiBfLtnesYMztEVll7JbKj3e+TES9REAwgkdJ9KKO
         6ANxrCQjTCNzdnogKRzvbfAytEtaunkUTNihJN947gCx3IN8h4wSU0uebFQgc9WF3v2P
         Qngw==
X-Gm-Message-State: AOJu0YxRpXfVEJUPsdbaA4S7scc4Eks86qEndBQDKeEolmIRBHRRwh3g
	xGdA6QpcdmhvIxdl99Rup9EcMSUcKonYu1oPAr8w3icQEV1qoBUnV6fX/kxnU8M=
X-Google-Smtp-Source: AGHT+IEgyiSK927zXIsO2K8ws+WuFo5rdGvLrwD1Uebv/Pcw7+ODrUZYJsEs7zuDgKzW3jgL4jxagg==
X-Received: by 2002:a5d:4945:0:b0:374:c160:269e with SMTP id ffacd0b85a97d-378c2cf5617mr1780563f8f.22.1726133347751;
        Thu, 12 Sep 2024 02:29:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956652ddsm13911677f8f.29.2024.09.12.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 02:29:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com, 
 martin.blumenstingl@googlemail.com, hkallweit1@gmail.com, 
 George Stark <gnstark@salutedevices.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@salutedevices.com
In-Reply-To: <20240710234116.2370655-1-gnstark@salutedevices.com>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
Subject: Re: (subset) [PATCH v4 0/3] pwm: meson: add pwm support for A1
Message-Id: <172613334685.3721802.3816923810532224075.b4-ty@linaro.org>
Date: Thu, 12 Sep 2024 11:29:06 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Thu, 11 Jul 2024 02:41:13 +0300, George Stark wrote:
> Add support for Amlogic meson A1 SoC family PWM
> 
> Changes in v2:
>   add patch with optional power-domains to pwm bindings;
>   fix syntax in a1 bindigns patch:
>   - use enum over const for amlogic,meson-a1-pwm beacuse adding more devices here
>     are expected
>   - leave only base compatible amlogic,meson-s4-pwm in check section
>   dt_binding_check and dtbs_check run ok now;
>   previous version: [1]
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.13/arm64-dt)

[3/3] arm64: dts: meson: a1: add definitions for meson PWM
      https://git.kernel.org/amlogic/c/b7e5f4bb555ba1d4fdad6f94eb6ab9f8d9c63597

These changes has been applied on the intermediate git tree [1].

The v6.13/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


