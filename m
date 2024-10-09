Return-Path: <linux-pwm+bounces-3551-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7429961A2
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CEFEB24424
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217A1187859;
	Wed,  9 Oct 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDPPCijk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48761187561
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460731; cv=none; b=ri57B5GhHK5IGzvdTpFp1LPxWOO1HFnG3hCsUwkQxHm2rbRVTwRz8LiqtfNtSpwKK9OT5vfYDR3YZzIt7n9pIZh5LPa7qrDiFt/aK0Xpa1sJEwjrm2domeyfme+WdsicWGwGc6nWQDfN9ku94rnyT6TwFbN/BDqq697b0hnUoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460731; c=relaxed/simple;
	bh=g8O0kpK9MpWWGfSwkN2fZwYo7lbfsttN4HuU//J2yCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CW2a+0NxglGDiZczvxZSz7lw36+oJPOQ6Aq0bNtKf4eGJQsAxeCTljfr+eNh/11X1s+2A4bIt7uf9i51F+8FynVhdrw+zqchXRekX+L8XF1DWdlLiIc85ECLUdxdfrgctUF+jQkBrCBJNRyyjH6VtG/nt1pZ86vboG0tWJnkPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDPPCijk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so52336935e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728460728; x=1729065528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjzblqqkUrGrcgPZNRxLPE0DkoF25DAjXSyZMk0r9GM=;
        b=IDPPCijkhfcmpmL5TaKgLrbhZcAfwsdPM8XDWEReTWzbbWIsEqnnFfffcmHOrtxblL
         evEsPoMud0skznqwF56iDdMeM3JYUEsM62LsBQfsY2E13DzcX/yN/1ehpVZbCV51OG/e
         nEuVf3YJp8c9H5onIGT7I8DoohsI4LmeuLec5ruiTS83JlS2XWCyaGD2xF1RkHB+OnoN
         nRgF1iMxmAWYn6Lqy6GQ6LDYH4SN1PvyoSVyFfPUG17HnKm84i0BQVJ2dtxhy7BuH7zC
         d9NYLatN7sFDLAFoF2yzbVDDeLivOaVcNXdiT3hJJ1tGU0bXlAZMNer855dL64zib19C
         sIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460728; x=1729065528;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjzblqqkUrGrcgPZNRxLPE0DkoF25DAjXSyZMk0r9GM=;
        b=Wl5ca30bZa54Vuxb7b/7XQRz2cMLLfKaOHlTFXasvMI/wT/x1p3lnrn1QNSM4BzYQN
         AGuWLJ0InuWmTeEULRWBY0i5+5NrwwqrMWmxzdxkBVFKtrgjoPN+zCcB1hTrJb0nm7mL
         fNr8xokpSB8oQ+zIzVZng/TStCWVMRft1zPgflfjPbryBBe9+/R9bUrAjM5h3Dtfie1N
         oSVO/UQVgsuo1H5zTchr5PKNidPi6VwlrDo9fEPT6Zsnonweib8M1iK7MqmKdZPqAeiR
         9biwhIlee5EXAv6KqSny8o8lBWxvq0PUpJ1WCI4V9MNU1Fz3w+rABi5wPcQsmHMaYcct
         uYvA==
X-Gm-Message-State: AOJu0YzDd0mDS35bXpA67g/4UA6PymaUN0/wCgfK1xSxojG3MLDLAjVA
	yIA/Vg1faNtycISHgIv/3OMwFAz9A/eCE4O9/Ey+JpPSlvu25v6Sf8+Qkk9+u6c=
X-Google-Smtp-Source: AGHT+IGkZyd5nOvtOQMkfiXw6MplVM65s68N7024BeRJ7gwwQuAN7MTfkYoNCh3XuzltFnAl7/W9Dg==
X-Received: by 2002:a5d:6dac:0:b0:374:c847:85c with SMTP id ffacd0b85a97d-37d3aa54328mr871144f8f.24.1728460727644;
        Wed, 09 Oct 2024 00:58:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d3a14bce4sm1157704f8f.92.2024.10.09.00.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:58:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
References: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
Subject: Re: (subset) [PATCH v2 0/2] Add support for Amlogic C3 PWM
Message-Id: <172846072651.3041625.14039974148857351568.b4-ty@linaro.org>
Date: Wed, 09 Oct 2024 09:58:46 +0200
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

On Sat, 14 Sep 2024 13:48:57 +0800, Kelvin Zhang wrote:
> Add support for Amlogic C3 PWM, including the DT binding document and DTS.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.13/arm64-dt)

[2/2] arm64: dts: amlogic: Add Amlogic C3 PWM
      https://git.kernel.org/amlogic/c/be90cd4bd422e8ae235f534a2fa46d40dae0816b

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


