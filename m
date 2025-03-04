Return-Path: <linux-pwm+bounces-5067-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B291A4DB35
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C785E3B495C
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BAB201021;
	Tue,  4 Mar 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lXUofKZw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42289202C38
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084801; cv=none; b=nd+BFMIDK+DK9B1UXdmumfHkJBzKLTv37S86p6wM5YRTa91KrOL9Q1HDscIjs+XBiiUvDdCtegGRqwduCeOLGvLOIGzDspDxm+AkWHp9Ahqh4fZs9CAdMlZPxt8drKtMsPw1Cs/GkOvYaYTPa4Qa3hIwslafPwwf+Psvzu/E0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084801; c=relaxed/simple;
	bh=nzgcasT8XlfuMCUiPfV4W/V1AJ9l8OcLLCDvCjZ+wh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxfqnxAs/l81bHfN6FeTP3qYb26qkcmSg73YwDWaEw++Yq8ul0ks7WLN12F16G7V0Z1ALFifAEuMAwdGZ3VRDoAYZbxINXVACkip5QT18AIkTnxAMuWX0JBr2HRBNQkDsasWbeiUZZXhc/1fEzIQPgubKRiIdkp2eQ7MAcVdvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lXUofKZw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2847434f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 04 Mar 2025 02:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741084798; x=1741689598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4NRBkDX3tmF4bL4mAlAFQOe0WTBDnxQ2hATnqOky0M=;
        b=lXUofKZwkeg5fvE/WuQp2lxCVJSFmUWajPm+wtvu+oMFDi0Y15yee0mX3AZNSTBkRD
         Djr8pva31HiMPD7CHIP4r2gRjj7t8UY+/Q6gHZab5NjFZm9WWkdlJLDRgQlWo+EwgoSh
         NrKNVeB3ifTsGZ32kv3wWJPfWQO1seOwiD4+E7y5nYGRqZ/IkCccg0y7Bq36LTwj9x/K
         3ayaxs8JJXRmqaceCRa3K8aS7EljOB2kVef+RHXsxB4wHzQtgHznZGCiQosVetVhHw3p
         dpIbKcN7Efob2ZtLvwLmfx5G++/OozelcfHcLLSB3KsqhGVhRyTdzSngyJ9tH3tZLkpI
         eQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084798; x=1741689598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4NRBkDX3tmF4bL4mAlAFQOe0WTBDnxQ2hATnqOky0M=;
        b=Brzi1wynKaz5Jf+TBtRZgxoYpxZfZsaamVpy//GDIHJ0/Jn3ILSugbhXkyhYLjaA/D
         DsoQ/gOsFtac0FL4psQW4jGJCCkjdp2KDcou41S0ynQmcn/irKMB4FcJchQ51OO3+j6r
         zRNRL/IhFXl+F0HFJrVOCCPhzLY0FmNiWfwzE/+vkQX/nAWIpvy/iyrRwKN3QRxfhPyt
         xeUd5A2+5nwq/pyco4Kb9AauSf0wI0KyWF+psqVEUyQAgT3q+GPuhY8aMAsshB7mttQg
         XrjmTEgf0HZvsgZIY2bBWXOx4vrtJ8JV0qJ59ta66xgHPqAqpW42EQa4c/jRNhsUrw6X
         f5pg==
X-Forwarded-Encrypted: i=1; AJvYcCW/SOkIvRmXNktH2vmnY3THX4owIAdreMm83nUqS6r2unEhDByRJ1b3cC26icADiecCoGg1Pcqpgms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0YtH9vt9/32+rukfx3swcH0j10EuweHMF6EFdwbYLZ9ndPM2
	uGTevfcI3IilOcIBMujZ68zkf3x9xwX0sec2tC0igk1TNgsZzY5QZ3udFK5X0M8=
X-Gm-Gg: ASbGncu9FberMrFhu0lprFY63/Ygv54UJ/AeCWCc9DYB3oS5Mcslz6DUz8QG4mdger4
	jTrdjvXMBQ/TeqR8GDH5fJNe0McjgK2As0ib0fEv2jXeFFbFnSJbd7uVwPLNyW38pRWJ4DwMd2K
	kSR7777vEDpqznoMNfuktXhB4AEGe6zuHXBwP5aCxfJ8NtIgiCVu0glohyU38Uu3ZF56kv3svo8
	UBM4SOnnOWbDvmolHO5+Gqv/n8Hw/RqAmXnKNrIkfMyRCHAqSWv2LGDIy+VTQKJqP5NHfj8Pek/
	ojWQIZtQ/OD2La85m59byVgZQmZFWTHKizl5BND9zeJm
X-Google-Smtp-Source: AGHT+IGI5YinM0Fmil/KbrQRp+7dyNZtKk6Cw3iHPUYwQZ6EfkAXgPjAmvyLHMyqzvMus9tjQNoGAw==
X-Received: by 2002:a05:6000:2805:b0:390:fb37:1ca with SMTP id ffacd0b85a97d-390fb3705aamr7047086f8f.53.1741084798504;
        Tue, 04 Mar 2025 02:39:58 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6018:7257:350d:e85e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm17602859f8f.63.2025.03.04.02.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:39:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: mvebu: Add missing 'gpio-ranges' property and hog nodes
Date: Tue,  4 Mar 2025 11:39:56 +0100
Message-ID: <174108479375.31979.16946190179335788449.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227175132.3734524-1-robh@kernel.org>
References: <20250227175132.3734524-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 27 Feb 2025 11:51:32 -0600, Rob Herring (Arm) wrote:
> The Marvell mvebu binding users already use 'gpio-ranges' and have hog
> nodes, so add them to the binding.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: mvebu: Add missing 'gpio-ranges' property and hog nodes
      commit: f2f3d5d62f6fbdaef46d1991086265a497b3e24f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

