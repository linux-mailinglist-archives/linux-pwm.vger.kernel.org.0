Return-Path: <linux-pwm+bounces-7313-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A905B56B8D
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Sep 2025 21:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F4106189C05F
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Sep 2025 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFC2DF13C;
	Sun, 14 Sep 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwtek0Nz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA92DCF6F
	for <linux-pwm@vger.kernel.org>; Sun, 14 Sep 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877975; cv=none; b=PePRc91Wn8NwrSC1WVNURTCf4TNriIq7RYaFtyuW3w8BIQINPRk7EdaHRJibK9aVcS537znSiRmC9gEvkurRq5o7XneLV0ITqZKL5jPzPTsvqBPeeiuUKa9nvsVJcHBRqWGTtVwkCEucpCyjKr1uRS7MTxDk66H7ZeoaEtxjDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877975; c=relaxed/simple;
	bh=Lm5i4b7mAVDGymTe6khqNmqSl5p9B05je89nzQDq8fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgSoabCyHQnq7YtZnABQ43xvsl4WM96m/tLd/ewElpAuKO8+7atV/ExladUx6HpoGiFJdVeMmUyLV4SRnwvceDkYRQDYlrwBiJ0KxNREaTAyc8S8eTEQB8XZq3tr3IGcPCIMcr6DA6gXPisWVgZI2sMxAGYVK7JKCuwTk24SWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwtek0Nz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07c081660aso490366366b.0
        for <linux-pwm@vger.kernel.org>; Sun, 14 Sep 2025 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757877972; x=1758482772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVTlEPKPlwuib9HCFIdCPPdpVMx8ZMnPeuxJ3eeRcq8=;
        b=mwtek0NzNrIT4ZW1UvQVe3z3ACd6LXFWK1e7PBFKMV8ForJ+LDbpByB9v5562VzzRz
         yQSNNCEeUty4nhCQ9oN01ET3FMX23IpUBMCI34Gl9QHoEVpsrlzuvKOZNifayE3am8Mz
         iuPqbiH2OZb8BscHFuYohImFY3Ti1bcqf0seRoM+cS0zTS4O8xv99oyhWvN3aa/JGVO3
         c6A/aXwt3SSXu8Qv+KKWrsfCERV0SeqQNDzOKH0TdjQxnXJ3ajwEJu2U7sZkqSsDhj/2
         X7DLQDZVm7rmWadRaVhbueERLdutJ7NK2q0kh70NZs03SNG/xljHj5mk+AwYl7h87i4u
         RhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757877972; x=1758482772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVTlEPKPlwuib9HCFIdCPPdpVMx8ZMnPeuxJ3eeRcq8=;
        b=hMpcrb0+Jv2Kq8JwK6KBVrLih4rwa4MAThJGpN//GOm7lq/jcvOXnvDTiPXbaQXvzN
         SHxDfU3j4Q1vTSbMOlSZDCqfgYQ90ZBjM8W/Pnc3NYJ+1em1pf0EZu0aysg1bjnqqoef
         G8DMXbUibJzTmOk1OC3VN6+1leBWuo++/5zlRR1giTcwU5ftvGU+Oa+3fYXDAkGihPX9
         wLjeREb3H7wLLpOypwicK3yxNsEU29Mmlo4zrQaRuwzQBOt5ynshtmpX/DYnOc6JsnyX
         4H0KHoGf4AGWD/BHD2ZmlMKXvzQWeo26kHLFTPOsIpPUApyjqPK6632QAfeYg9cJdgdZ
         dSEg==
X-Forwarded-Encrypted: i=1; AJvYcCX8vQIs8r59SqcEWzVqGe7F7vB85od2wNi8LViQaCVCD5/ahGbGg1/0V3qmhhqiUTCx2VTptgNu/6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIr8HeMFpgh0o8NKk3u4WAPyz7xykOEPONhkzd6UEywVit7Zq
	3AybSi3s2Zx9PecrXJ3bW+UABjue+iy0WIU5kGk3KKBUhjWz4qyKIVk=
X-Gm-Gg: ASbGnct6w7VpmBCghjASmWVbtBm+zZq20jbyVPVbmjLacrTbx2gRdpOSae+BAh2DDL6
	djnTs8T8iyvlFqic14E4UOmWlChf433z3FRdun6gLolD64CczXSqgq/HDw5bT2BRK3mvCHbVnxQ
	Bu/9JMZKj0Ht9Z7kDTJ+dDR8akFr8XnGlGm3yKVYaV2XPgO1nev2pY9foM53aTrvtzFKM61vla5
	J3H57FJ8GByke1Q25DLXZb3zjVlphEdB2qXe5EgxxD6xii/Mtq/89XFf9QhduK27Pmt0ohh4Hgz
	jnJ95vvqYTw97RTn/GtV/KxHdFHeMFNTySoucHc4Bie+ezf1QWaEUsYsj/nSo7XK/T75w8ch+uu
	Y00klMNHLbYRMi/RBmcnjcTEmQ4VEuTdxWDlYEJaE+WlPG1qL31H2u7AA+Q==
X-Google-Smtp-Source: AGHT+IHTzXsvzOE8gM88xrt61pYKRHy5EioOPp0Xw1v1cLK4amMFP8Qrg1NdiSmbj5h++KW+u3JMqg==
X-Received: by 2002:a17:907:7f17:b0:b0c:b51b:81f6 with SMTP id a640c23a62f3a-b0cb51b85e4mr435788266b.43.1757877971562;
        Sun, 14 Sep 2025 12:26:11 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:226e:7d72:f695:46fd:3aef:7487])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07baf35488sm707841066b.38.2025.09.14.12.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 12:26:11 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v8 2/3] ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
Date: Sun, 14 Sep 2025 21:25:15 +0200
Message-Id: <20250914192516.164629-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
References: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ti,twl4030-power-beagleboard-xm" compatible string is obsolete and
is not supported by any in-kernel driver. Currently, the kernel falls
back to the second entry, "ti,twl4030-power-idle-osc-off", to bind a
driver to this node.

Make this fallback explicit by removing the obsolete board-specific
compatible. This preserves the existing functionality while making the
DTS compliant with the new, stricter 'ti,twl.yaml' binding.

Fixes: 9188883fd66e9 ("ARM: dts: Enable twl4030 off-idle configuration for selected omaps")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v8:
 - No changes.

Changes in v7:
 - No changes.

Changes in v6:
 - This patch was added in this version
---
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts b/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
index 08ee0f8ea68..71b39a923d3 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
@@ -291,7 +291,7 @@ codec {
 		};
 
 		twl_power: power {
-			compatible = "ti,twl4030-power-beagleboard-xm", "ti,twl4030-power-idle-osc-off";
+			compatible = "ti,twl4030-power-idle-osc-off";
 			ti,use_poweroff;
 		};
 	};
-- 
2.39.5


