Return-Path: <linux-pwm+bounces-7465-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908CBEFE83
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Oct 2025 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E1D189D86D
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Oct 2025 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F012EBB80;
	Mon, 20 Oct 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y15tKSXK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50E2EB862
	for <linux-pwm@vger.kernel.org>; Mon, 20 Oct 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948691; cv=none; b=q/Wv686f2LlZGnrRoA9RpGJu8NMkaVD4xwES0KZ97Xyeq3KLnPW6pndLDaIzY3xjYKMjXLXqxy75iwdP+qIguKWb+aYBc/35ucZWJk1kduGgO/Tj0Fwu6rMQhgEIH1LlNA7m9RyYkdtkMtpYH9Qozmd5oIAdE55wcEjL1ihW3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948691; c=relaxed/simple;
	bh=9zlHdu1C0OX3LQKq/csViY4KOIK1A0RLur/kX4QaQsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7iR3uaxLMtPvUOdS/OcPUzEk0PxuAolEhYdCWakIUHwFGjGxPVxSJA6T++GU/67gB+uq/ucXy7F1riatzryGWgg5EY20Gp5dQW8aXciSAlwiX0M/F5ZSWyjZgpzMCmcKp8I8skMJ+N7FqwpHW3LA4ehYFgyaVk27k0yxqW2WN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y15tKSXK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4712c6d9495so12562155e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Oct 2025 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760948687; x=1761553487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW/AkTk8WlPjo3na4ACa1EYleQcJKdyDIWqp1NdXgKU=;
        b=Y15tKSXKDmQyX3VZJFUu8f1iVTx6lnd0y0zmsso2ucoAZu6OMaP2ixqT/IZC8e1Kpn
         tTOSdqS0l797ygAn6hUa9/VO27AXNTYZE+dH8458B5QOvykC8OYtE/FCPhKOP9qcyeLC
         ZUrhI/fkVY04tErNeJ1+bk/XomgWvE+HY2+4UBPrAVHNdbrYxSjLhEk7KAQYaWuSpoH5
         7v44T9vXbs+RRQqVMwH0qc8J+aJ3lXVSEuMOkCW1LN5Z+5PvPxNmrvAuVDLM2sQVBoIn
         UiyyP0cCYmYkciyOLx1jL6QlJuoS8+8KyyzGDkamE7aV7H2MFwcoty+2r8miH+CrRb0u
         xFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948687; x=1761553487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW/AkTk8WlPjo3na4ACa1EYleQcJKdyDIWqp1NdXgKU=;
        b=jS9NIBZOoiE5COTl8Vytke0wYWfX/HxE09t9NJOVOm45URHtcbv3/yPVc9RE2DDD/Z
         bgXYrwdQ55bTgFVWQRHouYycvyuvtY+U+7YhNyL0jlLwpuee2ANMjlhb+DRv0fTVfEC2
         BJut6Tq17G8ATlzMMuvZ50ZbsEwVb5RknSVZfmGXRTucp7CzN6uUuOznKIWAYZpRAE5U
         BFZAOuwlcr1W8Fba8k1Is8mcVe0LLRdgjPiFHiw+BU2a9cCMRxEX6j4Md6DF8YHFCSn0
         D9bEqLlUJ0zkxMLVDIpOO2MUGGKSVxcHixU281o2L0/bLPlreHZNfnTB8FT8lhRlEMSU
         EyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGZoYuCVPFl3fquzkMsPeJIRlloIh20jKcwbSYOf/8DSeUsfv5aas9mOfM4WKcNNK9Vw9AMbjvLzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7jpNXMMUpKe9TRuqSLcUJhqjnRzxDeKSseP4FgwoU+A7sHtSu
	K7CLHfI/dPb+Fa95FOBj7md8ZxycSrg9WIOgAgeF1pHc5SvXJviM7qB5r5UFiyau1qQ=
X-Gm-Gg: ASbGnctnlnc50cK5kJSgPYuHZ59+AUHy/2VxeCi9iFv0JVXeYcdEZpp+zon0kimH9qP
	ryUYhC/9G9yfO/4fDa8nMWXrvQrb7XzAPAj4BEQY7TU+GSYXmivEhE5kUXTAq8Si1ZD8ssL3pN6
	aGXg++QXrCnKa/gn7qvGewylROAcABtnXxkG56tIp4uTjfdVICQWNDtmTgFWkbqvUb88Qegs0zp
	7WnSFncpilHgdwD8fN8VzyAHoI4b/uRSYKKSO2WDS8Qf0BikvwiktP23BjkgT4S+xIIzA6Wspq1
	NXxndUI+KcEBeTgbhwap1H5wImonRs8xgMN0u2PusmblnEUFvoY5qQARMoJxik2r5KWAmRbLOrR
	vZxWMgQt/cC9e7xKaGqfEXfKV2lW2Kcn+QFpv+3NO0EuKFiLLsGdbVCaI+cUljoZyTrBxXv8qNS
	QR
X-Google-Smtp-Source: AGHT+IElbGLyhlp/1ybVdhj0rXNPZOg5gvo0dz1RPUfJES3/ZAsbvfhG1ocMD7SptwzEZ+DrjQdnHg==
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr69462225e9.13.1760948686986;
        Mon, 20 Oct 2025 01:24:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5b13:a549:df98:9c00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c29sm220299395e9.12.2025.10.20.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:24:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: mvebu: Slightly optimize mvebu_gpio_irq_handler()
Date: Mon, 20 Oct 2025 10:24:45 +0200
Message-ID: <176094868222.39929.1582779339210420040.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <7190f5def0489ed3f40435449c86cd7c710e6dd4.1760862679.git.christophe.jaillet@wanadoo.fr>
References: <7190f5def0489ed3f40435449c86cd7c710e6dd4.1760862679.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 19 Oct 2025 10:31:38 +0200, Christophe JAILLET wrote:
> In the main loop of mvebu_gpio_irq_handler() some calls to
> irq_find_mapping() can be saved.
> 
> There is no point to find an irq number before checking if this something
> has to be done.
> By testing first, some calls can be saved.
> 
> [...]

Applied, thanks!

[1/1] gpio: mvebu: Slightly optimize mvebu_gpio_irq_handler()
      https://git.kernel.org/brgl/linux/c/eb7f1c8415bbbb81f8674a490a5da7c22599a012

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

