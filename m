Return-Path: <linux-pwm+bounces-1521-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7396856289
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA61E1C2107D
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2B12AADA;
	Thu, 15 Feb 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx1FDUZs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FED12BE88
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998823; cv=none; b=JplDuLlLOIHay3P1Ry7VZbx01kHL9xxkQrCBoyRHWQddizJg7boxAu99+jSanelzzHVabl7laWD3Nx1MwmknVK94HEhb0SskIfJRRpisbarVq+NAHKd23IOIyWE8sN1l1N+hb9JUqH5XxdgEGwBGltZ7bqKd/ytM37KVNm/VTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998823; c=relaxed/simple;
	bh=6HsBMbgzYfxwG4TUH3pKnkkz/36cZRYAsjlWFRO45NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASvcUiQGdRjW2VBp0Hn2b9AkZxPoqR1ukCaQF/QzC0Z/mmqLzR33DYhdJtN/SeinGP/7xTtsmtYK0igkOPr/cgES0rotcuHSxOSZ9yDCFDt16btZX9ul+FCZi+JqWD5TIazJYPawh/kGzvwZIGFaROp15Cc1gJIJcJnFTIyVIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sx1FDUZs; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d208d0b282so7059051fa.0
        for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 04:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707998819; x=1708603619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HsBMbgzYfxwG4TUH3pKnkkz/36cZRYAsjlWFRO45NM=;
        b=sx1FDUZsIAYbIqa8fcta1xmjkAnPpCzNRLAif8KNIL9LpPbZCNglyD0nrdzXavxJJE
         UQxeZ7sdJLhmmOQ7ztbqdvcgUWB3w7i6Li3us+vxbMz9brfywL6skjBrJ0HqWVuBSike
         kAThfOZOlAJUnI66Act5tjcCLsDpkZk921ODv68Zjt5aO25lIu36yCV+iQqhoqOBrC5X
         ehM+0tbyMGawhRE+TB74vXRWb/BAl4XSfWsNysEPZUur774fc+3IvoFpK94p2GEhgQ82
         ng7tke+3xVmQb7GMTLjHoFCX08nl2zClOsBOeMO7OmkXUU4AFdGj93tI7fMwvzWOJIaZ
         CaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998819; x=1708603619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HsBMbgzYfxwG4TUH3pKnkkz/36cZRYAsjlWFRO45NM=;
        b=VVWtK8ibBBZd23NxL2PZVpniot532iJb60xPEmb4yfd9hnnMR5vRe//pr3Knwl12un
         kERnM8pO0eU0Qct9DQEq8Ew+IqWsEJS+OvlTFmnLF1EUEV+PJfEmUDq3e9oKOxJzU69c
         wm1dAMkakYMj6P+V8oALQHETSThomW8DPjwy5VF3Cltq/L1/ts4VP8PgtgG4haroA0Dd
         48eiMgESAmRi97JpDhH5+xAxEPRUyO2W8xFTLf4ri2y3AojhziObz0MX8ExVuKUg+/K6
         Wy3cTuaZDulYKzCsQLfWIKDd4ZtSVyTHlwqNU7gAE+TF+3WQ38jMjkOVWSr29J1Q/JtH
         OQew==
X-Forwarded-Encrypted: i=1; AJvYcCUnZeSyxaFy92OGP56ElSg/u8+3gC1ZURM/HaZDj0CtqNNRAgVded4gD+CXKeyKoOcJxz9m7XClKUm7JEs46Wik3sa+kqcmc4B4
X-Gm-Message-State: AOJu0Yzq65yjP10VY0uNvX8gg8ByJEnKHCGZjWhbVWCrRVnrv3j3Aixd
	OsQtflSip+uisLqdMelvEDGFfBAW1NEVrs/9qKYehxp0rRjsmycsi9oh5C5cjv8=
X-Google-Smtp-Source: AGHT+IEvCAE2Hh2zJZuwx6DONXdXfWx3DTN1g6LukJQSKZzMSvJwK0E8L2N9izM+RVK89lmD04+0vg==
X-Received: by 2002:a05:6512:3130:b0:511:82b7:9fb7 with SMTP id p16-20020a056512313000b0051182b79fb7mr1408077lfd.13.1707998819594;
        Thu, 15 Feb 2024 04:06:59 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c450a00b004122cfb5c5asm171291wmo.12.2024.02.15.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:06:59 -0800 (PST)
Date: Thu, 15 Feb 2024 12:06:57 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 05/10] backlight/aat2870-backlight: Remove struct
 backlight.check_fb
Message-ID: <20240215120657.GI9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-6-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-6-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:38PM +0100, Thomas Zimmermann wrote:
> The driver's implementation of check_fb always returns true, which
> is the default if no implementation has been set. So remove the code
> from the driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

