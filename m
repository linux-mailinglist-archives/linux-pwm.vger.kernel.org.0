Return-Path: <linux-pwm+bounces-214-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FC7FBFE9
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94BA0B20DE0
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D04F61C;
	Tue, 28 Nov 2023 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0dSmB2t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ACED5D;
	Tue, 28 Nov 2023 09:01:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b397793aaso27318025e9.0;
        Tue, 28 Nov 2023 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190916; x=1701795716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFbihvOvJFwZ+TLKehbVM5qaHn9LDZpQRGVz24GBN5w=;
        b=W0dSmB2tKPjLLcEZzZMiiPOIwxML2ZExqt/ZOS1wyCvQJF36djv0VBepIqvHgtfVPU
         cNxzizLVdjOEjOb3/SE3gybKfsUHP6FLrK8zAty965CNWbHI7wsL0wP6mufuUrlLpJ2W
         YQ2WOdccxdRZ0XoLIDE03Nfz1EQabHX08Q76W0Hbu8a502y0zLFrSOE6uRz49U8gXgLT
         3yIA/pBaNeYKvE5huEKOf9RXcQk1ueqw1eou/S4WdCRJ34fcYYl7O8qnTMtu+5VumGQQ
         wVkhwR6Dw5fILdcZ4ryqfgCOov5Uuq1945fiYS1Na78gRuVmO6XmSaVW6586w43judX2
         NLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190916; x=1701795716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFbihvOvJFwZ+TLKehbVM5qaHn9LDZpQRGVz24GBN5w=;
        b=trEpracvkXoSoNgS4kRZww87aQ9VodkPz0f3WnHAEqVa2/EZbQavTE/g1n7iE11+hF
         VMM+o//gfMAxIQ7rJ56tACOuz5oCVR1p/CHX8ITyfQ0QeARXT3bAKm1llcBN59AT3Y9e
         aqMuPs+TLyycvA9gSGy5dsxSLuNXR2SOs988n6mxolibgu/O+NkQ8lH7QS4+zD86ICEt
         4PlUHmYv999/lNGLl7b4WBDsRMg6BhvgMDNpZYYs3hz5HKHps0fegUKezLe06eKAHEg7
         nt/OBHHEBV4G1MI4EMdFY4M8t8y/rZGmP7tkgcYNjieA373hZBwoyY+aWLfldzD62u69
         9Ejw==
X-Gm-Message-State: AOJu0Ywm2XA3/oCgpSdhJscl8k3vZn/9FBCR8KoSbHtLvLZRTIb3KrOj
	tGkiWnf+Vv7VuA5CKg80qe1z96vxzDs=
X-Google-Smtp-Source: AGHT+IHUdf7LX+cvrmgeEt9reIcPS74OXrd4NwnYx7KIKLYmo8TI7Q7qGgWSL5Ft/uTpftLQEa5Tng==
X-Received: by 2002:a05:600c:4746:b0:405:784a:d53e with SMTP id w6-20020a05600c474600b00405784ad53emr11011181wmo.20.1701190915705;
        Tue, 28 Nov 2023 09:01:55 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b0040b2c195523sm19106591wmb.31.2023.11.28.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:01:22 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] pwm: jz4740: Add trailing \n to error messages
Date: Tue, 28 Nov 2023 17:59:59 +0100
Message-ID: <170119076368.215216.7694649613821090752.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123083322.405390-1-u.kleine-koenig@pengutronix.de>
References: <20231123083322.405390-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Nov 2023 09:33:23 +0100, Uwe Kleine-König wrote:
> Error messages are supposed to end in \n. Add the line terminator to the
> two error messages that lack this.
> 
> 

Applied, thanks!

[1/1] pwm: jz4740: Add trailing \n to error messages
      commit: 2d246fe011bbf5f17bcaa7e70484618aab0b975f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

