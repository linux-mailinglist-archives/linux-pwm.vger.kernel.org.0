Return-Path: <linux-pwm+bounces-212-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997D17FBFDF
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1101C209CF
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D9B35263;
	Tue, 28 Nov 2023 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VurrvPaR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC57D60
	for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:01:03 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso73192641fa.3
        for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190861; x=1701795661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYro1bHCL2ToH1Akf7zt+mwEJMgdbVtAAaNDTwybEkU=;
        b=VurrvPaRbtqfX/w+TDg3sB01ansW7b2pfYbjaf30ujEWmiVysamJTXaWJIMWhaD/lL
         5RfOZ936ewhsuX2zQ2X8MFjgeL3M1v/udSu/sDP+Nj/PDEA93Dr4e8O4SVTX2EYr7/A3
         qL2HDqqncj88BHzXKS44Yt6tK7EjjbSrRGBPvRIXHIvODMJ95Oqsp29Agng4vydrTd29
         33lgOeyK+CNj6Mnc9q8zVJVEUWDGcm1ObbzNR0v2Ax+QtQcxGao6bZAzZAKFKjbmY5kJ
         mD43Qr+1k7FEbHsXu3LHPxKLKuzjBiklwP9SWItHAHYwsEu+DBjPykuRSL2XgcJTiibi
         n3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190861; x=1701795661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYro1bHCL2ToH1Akf7zt+mwEJMgdbVtAAaNDTwybEkU=;
        b=ESM06c9H3tjSbpNYCwM4IrO9+o/r3/67Lzd8NTwvLMAHOCqDxTp1EI21juMcNvTv3o
         5bAPDmK7s0s2FVRWZQCzvmGGvlWceJfwBMUWxQ8d00fDLCVPKUg7xPe9RcXjJbYCLnkT
         xQusrweJLauWYMBcgxD8fqt/7SYG5EM0VaQ4qe2laf01WvOSnx9VrmHQHkv+E9c9PqfL
         Ez3PFjzj0nOc6+DUAeKTVfEtbO0gUOTnCxCsZceBnQvkkCy4AmB+YRFGwQJpQ/pK2no3
         RNaqie+t0DPY8ngnFF0MuDC9a5uEmcCOkcb//JqLunjg92wMu3T9XkKiz3X1I/SDeum2
         oE+g==
X-Gm-Message-State: AOJu0YyLqYeqk6665yPrEb0pM2nrmu5cR5aSFM0J/5/A1UQxNnm2FPxI
	x2MLjBnVJwedQPZVJazLbCsVMZp+yIQ=
X-Google-Smtp-Source: AGHT+IFlvcjfa0UjoapubFTYuwACiKFHdCwJCzXOA6enIAUfNBO8szeU2Pq9i1fzH+bIcOzxxHwK7w==
X-Received: by 2002:a2e:a498:0:b0:2c9:9727:39f9 with SMTP id h24-20020a2ea498000000b002c9972739f9mr7249372lji.17.1701190861063;
        Tue, 28 Nov 2023 09:01:01 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003fefaf299b6sm18207805wmq.38.2023.11.28.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:00:41 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] pwm: core: Narrow scope of struct pwm_device pointer
Date: Tue, 28 Nov 2023 17:59:57 +0100
Message-ID: <170119076369.215216.16752436461397952131.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123095619.424895-1-u.kleine-koenig@pengutronix.de>
References: <20231123095619.424895-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Nov 2023 10:56:20 +0100, Uwe Kleine-König wrote:
> In the expression determining the size of the allocation for chip->pwms
> it's more natural to use sizeof(*chip->pwms) than sizeof(*pwm). With
> that changed, the variable pwm is only used in a for loop and its scope
> can be reduced accordingly.
> 
> 

Applied, thanks!

[1/1] pwm: core: Narrow scope of struct pwm_device pointer
      (no commit info)

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

