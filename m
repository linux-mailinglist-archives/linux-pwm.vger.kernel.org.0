Return-Path: <linux-pwm+bounces-7816-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B52A7CD1083
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Dec 2025 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14120303B11C
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Dec 2025 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099BD3321AC;
	Fri, 19 Dec 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZtHe/bz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA83009E1
	for <linux-pwm@vger.kernel.org>; Fri, 19 Dec 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163791; cv=none; b=Qj7pP4qvq5g6SLPIjfcGDbBrpsSUiY66sDRVvVzmjSTnmmQPbtjSc7lqBDpOjYH7cqluBP21OzAPcbTI4S9ATOoPnvdEusYfezlP2op57iEEe2xKw4mbvlbS8XAHUgvtoDcWKP8uvuMR5e5e3affZ1gaGKCAk895PeHgU0yHUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163791; c=relaxed/simple;
	bh=MOztO0P7PwlZHz5MTw/Amxw99+/HGz/RSqn974zbfWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KYXA4iBpVpDisATZPm3VtZ1LFEkRvTBzQ86NuDmg7CikSkhyGmhfCgZDgFzaJV5wwQu4QeCYEiebihye0SFlVv6MYkf9eDJHIcxceEdB7hIVtFcOgTQGIQY3oP8CZqrNka6Dy2QKZwLsjip0KDP48OgxSm3Y/4TdZILA/Zw+30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZtHe/bz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5958187fa55so1640513e87.3
        for <linux-pwm@vger.kernel.org>; Fri, 19 Dec 2025 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766163787; x=1766768587; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz7fEDVsMksd53FQR3xu4YMFpwFbfQY0PYbyvZxWAk8=;
        b=WZtHe/bzgchKSwhimldWbgquqDEiAj/UxfE1Xmro0yDe8rzQazPnKxzwyO3h3fZP57
         G7cU6xWCjTEeWCsAN0J/9pW8FnrrqGBtEkQQkSurulnLrm4NM5VCaerBsV2Q8iRhUGEO
         KeG6RCQIz+cS452fGYJMCfKTyTpJYm+f41QRvhkB9DnNXU9XDhkv7cTLec55qRHLK2S2
         l+u3698Aj3kB25MjHNsfkLBc73uAzFeoo5UOcK/Zdewk5Iat+QhiHRDelvg4z8Ji0tmd
         8zmEOEB2VO82LZEsZOYjMo5SiqWBktpiLyVgKS2gBmqm6J3frQ36zW6mcYMbLneDyn+M
         jQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163787; x=1766768587;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz7fEDVsMksd53FQR3xu4YMFpwFbfQY0PYbyvZxWAk8=;
        b=k/TS6l/QHoDt1k1zn65WRsFLlTuYZTVwV9k/vpIC3Wy5uqymOKYJRMkPrPIpLdMM7e
         mS+hOBXf/k8E7ucCiN83R25NvhRTOfIwOyPrFjxXWAe4pmdfzV28MnyjvfFlJXEU7Uyd
         L9bHDEWKGFhhvDrJ0u6dG+vNF8MMSd24b0uaogWXWzVvKq4el9qZ0envzadR3FJzsf1m
         0NeNSKzdtfaK6r2rykvai6K6Z6VJnqr9RSrgGK8F6eHaBZy3H8uX/w6U6mNdHRqMnLhW
         5Hq3uQt5Euf3mrqQohpDzTI5ZtzZ32kwgmq6TeEJqTHDgLotU2AYoT7KW0NIHgXaOsMB
         wyzA==
X-Gm-Message-State: AOJu0Yy9VFL137sQM9Az2FtW1GjNZwo4o7VnuSq6wO2r8FOv2ETCzrqJ
	wHfJM8+tPguevo5QIe+cnAArn27Vgq3WdPnXWXLVy2hZ7wFl2UOyIVXF
X-Gm-Gg: AY/fxX6IL54JRxde5wY6xyWRyxOwUz4s0a6wJGFDQ6EmCxqtngQ3XLniX2KuOJ5GdWA
	MlTKT2fsklfTnVMH0gPsXOa67mCOnPLOLYuewO5zGLtrDwLeeDw0agbIRRZSCLuZVuh1IQrVFCY
	Ji3o9G2zPCUmQmLKmWTtiwAzauk1ECXLcelE8I5KlNCjw7LDJi+XxtzZl0TLjHpajpY9uvqWib8
	DPv1DPVBVWzEIHWu6FecMp/8OBilqD01AFdDB6f9uNqltgnUCUxkvLvflIGZVSM8ekyT5Rzd56g
	iQNP3sl9skPyJAQSyylxkx6P7B4a4oE34PIQvqLCorNHWKpDQsHgKbEhej3Yy7rasYa4M1B0yLs
	umdzn2uz6eQTPq9hohifIU1ZS+ZIuJKJqmHPosXx5Hq9Vk1KsAixxisIUE4JUMG1YFuJm6klm19
	x2Hdb21JdOQXn/IlxzXAko36kn7pcgTyU+4Pwt599fxnAR/qrHVrfoIuWTrzliGXT7c5tYUghTh
	OXyyw==
X-Google-Smtp-Source: AGHT+IE4wSXDpK3wSsUYipEIF+ESaqmYYzJR96bb8ev9zx1V/MWzqFSMoO4gqhj2EDNdB1r/7KiGkA==
X-Received: by 2002:a05:6512:2390:b0:594:34c4:a325 with SMTP id 2adb3069b0e04-59a17d66a47mr1292946e87.46.1766163786980;
        Fri, 19 Dec 2025 09:03:06 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (84-253-208-48.bb.dnainternet.fi. [84.253.208.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18618d6fsm828449e87.65.2025.12.19.09.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:03:06 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Subject: [PATCH 0/2] rust: pwm: Fix init error handling and tidy style
Date: Fri, 19 Dec 2025 19:02:50 +0200
Message-Id: <20251219-pwm-rust-v1-0-46873e19679d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADqFRWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0NL3YLyXN2i0uISXfOUNAsTsxSDNEMLYyWg8oKi1LTMCrBR0bG1tQA
 gA9kbWgAAAA==
X-Change-ID: 20251219-pwm-rust-7df846d0f183
To: Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766163785; l=789;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=MOztO0P7PwlZHz5MTw/Amxw99+/HGz/RSqn974zbfWk=;
 b=eTkJF05FNKBZv1FiihR+1qN9hT8X07ZnDcwWwRxJDdAjFESd6XFnhX2y4bIjTzIF828O1w8ck
 WbH2+ZbBu8aCkeeVArw3eDRSPwEA5zWSsrupTooZrhf9CpdYKiITiZP
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

This series contains two small updates to the Rust PWM bindings.

The first patch fixes a potential memory leak on an error path during PWM
chip initialization. As currently this is impossible I did not cc stable.

The second patch is just style-only cleanup.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
Kari Argillander (2):
      rust: pwm: Fix potential memory leak on init error
      rust: pwm: Simplify to_result call sites and unsafe blocks

 rust/kernel/pwm.rs | 54 ++++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251219-pwm-rust-7df846d0f183

Best regards,
-- 
Kari Argillander <kari.argillander@gmail.com>


