Return-Path: <linux-pwm+bounces-3628-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2A999C36A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 10:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3283283A24
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0F159583;
	Mon, 14 Oct 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Wao6WulG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488D158A18
	for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894720; cv=none; b=rc2fXraSGM1UMGka24V6W2gmEq0gSamYbDt+U3hpPConQN/KJy1kF+XWJ2VR0jlsY8K1FoAr2+UY1UmqFJzfvVbjV9VAfqn9IFyfn0SHspiNVGouWcCk6O6Xj5f2JoTP7c5TGCe4JHbSHGe3KZXaAEsiWjaxXzCmPL2qNZ0jRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894720; c=relaxed/simple;
	bh=HOQuL05aTcz38UQAXd6dFnZM0C3Y3Fs1xb6v+HFs2rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=he+oVGxCSS8JG8RiZP44Tn8AV5VCTJAdhU8udoXQ6fvyK0s3OIwFQ4Zo9RHoyrXwZyC1PDUSs3h+myxiHSiOD96v2PfWQKTGzyuyY86OxiV9yOJUjYUNofHS6tS33P6CP2HmMibc0wCc2acRVLA0Am4IgmfFloeASoAqLBAQSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Wao6WulG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4305413aec9so39045255e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894717; x=1729499517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnqEt7xHoA/xDc8TV9q3o1UbtE0Cr8uGVizTXc1c8c8=;
        b=Wao6WulGa/RU9eFMHjos9HqE6IVyuZ30AoThee+rH1AojU+kjg2w5scjTX1cHDv8nz
         UoXZTd0qCZTSLrp2jOGmNqTCh0sLjb4JOn9HFZtAbedYMFDQuzIEQyaymPukHZ5xdzx6
         s77B0nvYifBlGXfVqjfLPQxDYk91+QqDMYSSR3iZ1Q7ulBvL4wp5NvOWOVWXHFZGHuPc
         twmIHpemfCbNzidHoHR1EH6V2EQRtsn6I5tBhDXXo98s8P/bHabCj2DVgJ7RMPKzExVd
         lP3/VTKtq1rG11Sg9NzmgXA6Gkj369oycyydxuC/gl2Kx6WMwZ+GgpZyaQhlJ0qGwQFQ
         0q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894717; x=1729499517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnqEt7xHoA/xDc8TV9q3o1UbtE0Cr8uGVizTXc1c8c8=;
        b=XRIm1HSelBndgz87X3MXTgF73Wts4oQpSw1iDsCa9oys365G0Y5vPYlPFIw0AhXdSo
         yrsdli0yqYngQZ1N+antqW+iubRNRZI9DFC6qey4HD4I/oP7FI8/LqDB8S7e7Ys7g3D3
         k8HhniUxehf6Z7vw6GXAPuhwVVHBIkiI75ZegE2W3OQPv1ZN6lQ6bzHGK9us2dSJScOS
         M9fiBm/RtPDiSaMHLwZ+wNFlgCP6h3r82S7pR/Y18L5YJChimxjcZMpTq19wj4lRSONE
         O/DHzkMJ38AAh7MCoKSVX/BOpxyelIEnozAmau/ueQoWsSIFunjorbwh4W/ggKq1di06
         TOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKGcA0MYEYf4ZKwyaJ4SBIy8t3/MiAh1Kb+SKBBYwWGiGpQMXHCMLQ5AK9khUUwzinC72gq3CQlj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1Xc6do9PLkM7990l4uJY4DUe7KpW8ugxbg25ZKeR+xC87xJ9
	Ha6BOA0TDUZfpWNpmLVQpiH5oeTrt0tNIiBl62qLXuIqdhCF6Rd3qmY/BRoHhX4=
X-Google-Smtp-Source: AGHT+IFypyDVPNB7GTsY0jbyqffL/WpbjaCVbT/mDxbT4wDXJ36Piix6XrL6ax+D9xuwuNyBr5Jfcg==
X-Received: by 2002:adf:a306:0:b0:374:c92e:f69f with SMTP id ffacd0b85a97d-37d551b473bmr7205594f8f.16.1728894717195;
        Mon, 14 Oct 2024 01:31:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] gpio: vf610: use generic device_get_match_data()
Date: Mon, 14 Oct 2024 10:31:36 +0200
Message-ID: <172889468798.57095.6447484996457464693.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007102549.34926-1-brgl@bgdev.pl>
References: <20241007102549.34926-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 07 Oct 2024 12:25:49 +0200, Bartosz Golaszewski wrote:
> There's no need to use the OF-specific variant to get the match data.
> Switch to using device_get_match_data() and with that remove the of.h
> include. Also remove of_irq.h as none of its interfaces is used here and
> order the includes in alphabetical order.
> 
> 

Applied, thanks!

[1/1] gpio: vf610: use generic device_get_match_data()
      commit: 1b35c124f961b355dafb1906c591191bd0b37417

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

