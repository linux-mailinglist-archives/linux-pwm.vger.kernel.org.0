Return-Path: <linux-pwm+bounces-213-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E0D7FBFE1
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223B8B21459
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352A49F89;
	Tue, 28 Nov 2023 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns4Rp+18"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E7CD4B
	for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:01:23 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso71616101fa.0
        for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190882; x=1701795682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lK2p/jNe186m6MQkZUw8vYHNpY87UOhpvk6tr8/V7o=;
        b=ns4Rp+18ywfsM+sXeoUrsoGDXk2G6z+L1qS/iEdcykUqkDcFV7xdEZcD29cEbBaKpP
         cqoR8lzEShbwQ9UhK33I311B0R81aqaQROyWeDd1l7C6Q2sgGCdiaunnpVN+Ddy6vMCd
         DVc+WMphxHY+dwIbmHEMfdc2k1Q/sdU1y6IpfwbXPYm2BKmtUgy6qDaHK0ODwNFAAcUj
         wzpsWbnPseK/SJKRK0XUMmIj3VTh3FYNV/BGQybSzSHkFztftz2jtZIuWMvBT4C7r3Uq
         BKWj5v39eF5kjD+ncUbmQrYi2Ci8C4Z6txjEzKQ4RPJkQrIgff2leyJHiAPpdD4GX40C
         XHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190882; x=1701795682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lK2p/jNe186m6MQkZUw8vYHNpY87UOhpvk6tr8/V7o=;
        b=U3keKRHKFJVEfGwzAkF+siYcdt8Saigk07FdRIVJN5X+3IQ9PCoprDPISXQOGOPnle
         hExP+KEGGfzjH5nSamkCBPJ2PgJUFmUbuyachQnUpDFLArDGQPFkpdcLDXP0ihj8XK30
         b9uHMowZII3Kx/qcSVk2YgIJuhSpW8QXc5u3EJuSlT7j6kPzXLzVN22ZB7A5cU8pTfAy
         hHcHmLirL8XLCslvNoGE09vRRf8IuucN+bqvlue3vbBMBdCekdy68BQ6hQCgqaKQgakI
         caldK1g9v/eX0IutUhjtmYT1A0b58RlqzkJ1gpqUtg8yZBPrqqshZDTIKNUE1oVHL4aJ
         cpUQ==
X-Gm-Message-State: AOJu0YyFu/NPr8AjkCiaxgB0BVWjaL5tG2W5Fsz3AtMNhN3W+2wMbk1Q
	ZHqCo6z1U8LZ8P1VXXWXBhuTCtYalTk=
X-Google-Smtp-Source: AGHT+IHUHm0IKPYOQJqLcMoENzn45m8AxBNvp1+QSlmWrXCEIuZk7di03TNpipCUVYLt57DtFkI7RQ==
X-Received: by 2002:a2e:95d6:0:b0:2c8:874b:8f19 with SMTP id y22-20020a2e95d6000000b002c8874b8f19mr10440648ljh.51.1701190881477;
        Tue, 28 Nov 2023 09:01:21 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b0040b32edf626sm12486784wmo.31.2023.11.28.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:01:20 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH] pwm: cros-ec: Drop unused member from driver private data
Date: Tue, 28 Nov 2023 17:59:58 +0100
Message-ID: <170119076359.215216.1319567862896668044.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116105212.650951-1-u.kleine-koenig@pengutronix.de>
References: <20231116105212.650951-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 16 Nov 2023 11:52:13 +0100, Uwe Kleine-König wrote:
> .dev is unused since the driver was introduced in commit 1f0d3bb02785
> ("pwm: Add ChromeOS EC PWM driver"). Drop it.
> 
> 

Applied, thanks!

[1/1] pwm: cros-ec: Drop unused member from driver private data
      commit: 53231af13df265cb46da99d5936ed270f22a35e1

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

