Return-Path: <linux-pwm+bounces-210-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F657FBFDD
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B67B20A84
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B982208B;
	Tue, 28 Nov 2023 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMk/vDw/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B7D4B;
	Tue, 28 Nov 2023 09:00:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so17447835e9.3;
        Tue, 28 Nov 2023 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190810; x=1701795610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELFRihX3CtF7RhjnQusbjB/B/hfaZV0Nbj4a0FnBTOw=;
        b=nMk/vDw/bQ3U2MUGiawahLWPTghwX0cvsHV9mKDCqbLQK2j9iXuZ2V/kqBn0xObzB3
         OL6defTnXWwPHJeyY+j0VYP7uUIEw4wxYjn5+I5FZHbtUV2X6+3qClbALgpODGRGRNiD
         p2IeMI0fqT044oNYVx3XR+GvyZomxbosPUhQkeUwaIEHEUE9PpdgpDiXJCI8paVQ73VD
         wxJz/v65+FuANiBrEqINsOfA4XZAoBE4M4343tho5l/txBGn/nlOJFoIvPmGdz0J8RPy
         L3EehZJrSmjb82VHorftknQoGiOq9K8iFYm901Xs79jLhBnOc5Hq1jaBG6/T4Nk19e46
         Oi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190810; x=1701795610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELFRihX3CtF7RhjnQusbjB/B/hfaZV0Nbj4a0FnBTOw=;
        b=bDqVoQVof7y5hTERSpluAnWzgboAARlYi0UzkS+3xacQ+f46qHyJ6MD25UBjupXKdA
         WSNR1H4w/5W2HTlYSyfl+Dnkg3D75q/X9q6aVyXmGIudogTGiIK8jY5pymFqtN/ojbyq
         rNh5LmVFlqYEbD8iZeQYXGs+Bb1vT1M1FiUPJSR7Sg1VSMYzM4vQdY6fqNiOsbBXLbCo
         uBbAwAUvt4pef90MGw+BhFwrkfYVkLuSW1Dj6bo+7oe/YMaiHBdJYGUNsuEiMOrzfPH+
         1YJKT+rMARP/Yk8elFosf7LXfmU79SZZLlVG4eaxPsIzOdBXeKP01/gVal7E/cx2IhgJ
         WkqA==
X-Gm-Message-State: AOJu0YxrR4bvdCMgCjkqUIvXILJb4A/OoBkqZJZXx6DTcc3NvEx1GmNd
	2qAk0YCiPgajX7fVYdJq2jA=
X-Google-Smtp-Source: AGHT+IGgm/D1KmtQMgeCyY/5kKBhGpQJ2TpH2E/ZvVJuY46OvL1ykEusYln54WAR+F0TPMHS5lkZzQ==
X-Received: by 2002:a05:600c:3b83:b0:40b:2a53:7913 with SMTP id n3-20020a05600c3b8300b0040b2a537913mr11464033wms.13.1701190810132;
        Tue, 28 Nov 2023 09:00:10 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00332cc7c3aaasm15618353wru.21.2023.11.28.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:00:05 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] pwm: Use device_get_match_data()
Date: Tue, 28 Nov 2023 17:59:55 +0100
Message-ID: <170119076371.215216.199281430371759022.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026195417.68090-2-robh@kernel.org>
References: <20231026195417.68090-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 26 Oct 2023 14:54:17 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> As these drivers only do DT based matching, of_match_device() will never
> return NULL if we've gotten to probe(). Therefore, the NULL check and
> error returns can be dropped.
> 
> [...]

Applied, thanks!

[1/1] pwm: Use device_get_match_data()
      commit: cf5a1a8c8e8875b3fe38835942b393cc1577da55

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

