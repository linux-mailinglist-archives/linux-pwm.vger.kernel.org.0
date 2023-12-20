Return-Path: <linux-pwm+bounces-590-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD8081A3B8
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C470286A04
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92D41867;
	Wed, 20 Dec 2023 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3NrEUho"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5347791;
	Wed, 20 Dec 2023 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so62444425e9.3;
        Wed, 20 Dec 2023 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703088370; x=1703693170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qhoRVks26Z2LPNmZUcy2Sm6yapbUomuWPvB4Kiie/Y=;
        b=U3NrEUhodv2jL9Hlk71fOMTUrPNNm3gm7IHsMzpemdANc9hIOkXtYOjP94Dtvq1JYi
         R/O7uMfkdltY2m/p4xFoA1Nj6CnprLsp9/juZuA65ZFd0he+6huO09VWrfpVGMUD9pu8
         vvBMYmliM1c6VyxKUV2xd/LjfJw1eG3fHXKul977Ube2CvajpZMTKP617lgAJly9+nxN
         zXqx45TUMYnGrFDhnI4yvh1S8IR3aGfUyRwmXN3BBXQhEGvGgitk2huSAPsgXPmBd6tg
         awK55sg2D3WAIvxbX8p6YbQpYfY+rNqZH7JKLvhCUgMqG2zs2Cwe+05NmXY2+mtc+P90
         v/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088370; x=1703693170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qhoRVks26Z2LPNmZUcy2Sm6yapbUomuWPvB4Kiie/Y=;
        b=EKY/Yvn6+Ujwlo1mizV+OeC6IO5eX6gpJyvQFqhW+bxZWTOB9GdX/AHCkpCa8nBE6S
         wK6oRvdIAfKHJFvRAJs+bfSEH4wZYhdIsuAgur7CAbI0aaPjlhKbTQ3mPyPRThRV7c2x
         yP4C9LNMKbCYxOgvM8wSiK72XjnzfJqpfezyB3ZZDX457bC+Rlcml9qL02dO/Epu+fo5
         fCL+spQy7ni28fY4AsQ5pPWxW9nuRZO6bLSg3qcw4vCsTreCzuHk045Cp3DtcQBduCc9
         z2mVOtai/x9V+DyEs2zioCnHBl4Ue4fim1NlexXTDKN41EEpdEmGFUwIPnqEHLBwd5Eb
         yaMw==
X-Gm-Message-State: AOJu0YzM+mibT90Y+zNQgmhh27BgaTLOzL0IFvp03ZubZSWNEd6dlE+x
	atcS8cjxZeHUtRU5WTE2xPH3p5TEaHk=
X-Google-Smtp-Source: AGHT+IHZXS5ZnjT49Qe4Ctn0BFVUf3gGt8VkMurJYIfCTs/fadyMQnZr/bq3wmr169lxb6iT9DB08Q==
X-Received: by 2002:a05:600c:6907:b0:40c:2dad:d394 with SMTP id fo7-20020a05600c690700b0040c2dadd394mr10473222wmb.149.1703088370256;
        Wed, 20 Dec 2023 08:06:10 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c10-20020a7bc2aa000000b0040b2b38a1fasm98946wmk.4.2023.12.20.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:06:10 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sean Young <sean@mess.org>
Subject: Re: (subset) [PATCH v10 0/6] Improve pwm-ir-tx precision
Date: Wed, 20 Dec 2023 17:06:06 +0100
Message-ID: <170308520277.565566.3116568532099401071.b4-ty@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703003288.git.sean@mess.org>
References: <cover.1703003288.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Dec 2023 16:30:23 +0000, Sean Young wrote:
> The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> from delays as this is done in process context. Make this work in atomic
> context.
> 
> changes:
> 
> v10:
>  - Uwe Kleine-König review comments/fixes
> 
> [...]

Applied, thanks!

[6/6] media: pwm-ir-tx: Trigger edges from hrtimer interrupt context
      commit: 363d0e56285e80cda997d41d94c22313b673557d

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

