Return-Path: <linux-pwm+bounces-238-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED807FD6B2
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 13:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A151A1C20951
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8C1DA56;
	Wed, 29 Nov 2023 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcvSGuGR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C810D48;
	Wed, 29 Nov 2023 04:26:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a0b65cbf096so590787566b.1;
        Wed, 29 Nov 2023 04:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701260759; x=1701865559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9viodrxXNdj6asj6Vfl3mqqfWCQOtvTzy3eNWtRL9A=;
        b=PcvSGuGRu6sFiAPRQw6vLr/QVEujyUaj7EqIVSbM3k4W9HIXYsiJCieSF5QpsGrXHQ
         kS01Ih3lNWCXGN1AifGlewO3+7Tb1e4uFXc6uINqvvFoDpq5B1qA9q060HD8Xr4PemlJ
         oZZqYcUKKH/wdbbbT3m5vuJOIdrVq0o1HjujdfZbrAl6b0v9kqZLGdblPyH5mL7ygB67
         lJaZCpItwZIs4x/fvJvtlb6+C4r0HTKjNTsp8FheD6fcCOvQcTmdw5xHgr126TwS0aCq
         +fjmYC+rytda+v52mfB6oIm8cQ94rE7C8pZfOgIYH0X7j+qrNtcj/ZL6bn0uoX2CCK+k
         EgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260759; x=1701865559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9viodrxXNdj6asj6Vfl3mqqfWCQOtvTzy3eNWtRL9A=;
        b=sGjTAFMWRqYlpWI2FlCkeO/mnT5ztPYdm5be1qdgIz/6qD6d5qvPIF5dYJ/Hj+Ng6T
         QrUViHpw1OCgdnyy1SpY9Z+SUflOhlEhSOP49HjLtPNUD++M2Amua23yTwaN5noKVkaD
         VP7m9gUw/a8NsF3ec7x2XRVDAw3WYWbnJLPaOubW6Um38CayJAY2ji7iihf095BqDsET
         X2nE1+7xGM0eE/AXrR0oYR54LWnjq4P5KTeZpoPC9X0PIMwSz3PeZsA/9V9fzNemvNHl
         flSkLr+aJtWmDvzPFtJwmK+HNbZXWNJ8aDZPYcLccZ+H3GfC2drEgPCrXd8Fty1/c5O1
         9/1A==
X-Gm-Message-State: AOJu0Ywt+2oR+w0aKuYvXPSnuJhvsgB7zsS7/jK1etssO3p38PxcU/ZU
	55RCPm+oadvMwuOI+a99UXU=
X-Google-Smtp-Source: AGHT+IEBEwayUX3L1ODBT+6O5vVXOFdRqoNGbEWVmreIV4DlK+MXeF07PXVsw0SwKDECv7o5u5qYTg==
X-Received: by 2002:a17:906:6d8b:b0:a00:b4ab:cb6d with SMTP id h11-20020a1709066d8b00b00a00b4abcb6dmr10449582ejt.69.1701260758454;
        Wed, 29 Nov 2023 04:25:58 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709064f1200b00a173547a28dsm642734eju.195.2023.11.29.04.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:25:57 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	kernel@pengutronix.de,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] pwm: Update kernel doc for struct pwm_chip
Date: Wed, 29 Nov 2023 13:25:52 +0100
Message-ID: <170126072780.448555.17859780866289805734.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129101831.908952-2-u.kleine-koenig@pengutronix.de>
References: <20231129125826.08d7d178@canb.auug.org.au> <20231129101831.908952-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Nov 2023 11:18:32 +0100, Uwe Kleine-König wrote:
> Commit c572f3b9c8b7 ("pwm: Replace PWM chip unique base by unique ID")
> changed the members of struct pwm_chip, but failed to update the
> documentation accordingly. Catch up and document the new member and drop
> description for the two removed ones.
> 
> 

Applied, thanks!

[1/1] pwm: Update kernel doc for struct pwm_chip
      commit: 53a2eaaf19c4e652ac53b5b2441582a555768516

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

