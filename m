Return-Path: <linux-pwm+bounces-6521-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B76AE738D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 02:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A512F3AA8D1
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460B800;
	Wed, 25 Jun 2025 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ+n/YzL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A51FC3;
	Wed, 25 Jun 2025 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809692; cv=none; b=MCH8tB8BlNBPcGzUvOgJJ1eNMEcxoJMucOLJwoc8hwF1p+bd7J51h3YKzWrlXMHmWzVPelPI5lYILzdMqVIFHnvPnvFDRCAvrjUyYEl/gsA4/Fv4TAmc94yJTDNOzbmfxUR282WQC9DneUsGuqP5By0UlHGlniEbnJtfEzfYjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809692; c=relaxed/simple;
	bh=XnG87dmXwG6nT6PZO8owpXYr9wlPy+BSzw5IHXw7rZ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aR84ByGmlQRvs9pJ8CUdsFp6gmzUeytj+mgICFrz0fTHAw5wop6RuIRydHH2+4MfjqKT7cD9E+JgmE+4aadd4oG8wVxKowYVdIS013a9Z+gM4IxrZ0FZvQZ8XFrqHbR1a+rY4zl3q90g5giV/rY7wb5PL7LikwSEnAh/Wewe0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ+n/YzL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4531e146a24so5962835e9.0;
        Tue, 24 Jun 2025 17:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750809689; x=1751414489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJDOvPBrrF5J0oB9ou929TdF9QghUuaRWuqk9z1EFRQ=;
        b=GQ+n/YzL2hw7lGCma91VrkrMMPUjBKOhlkoziipP7Gsytep28BycDc4fNBUTZObJDl
         6gDeo1oNYVpm/Iyy0yUOXyC2YblqE1xnQCRFeu7dCLzTKaHwrQz6xDz6HfnriIe+eZqa
         5zZSMcnhbR/xZCFYIAIJjuGE6KYmqTpc76G5ul0vDZnMisYMYc9bUwUQKSoxgK47gt9c
         C+dM5beV+MNAgOyJx5Nz7OkEW5WjrX9u+70zsr72Qscr6z1iSmhlCq7bjNG5HZ+No7S3
         WczhQ91AHP5FyHyKD3ogVROo2nAIA6brQ/sawDhI+4k/Zpp1yrG3cVuE6SDm4ZOK81Fu
         vzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809689; x=1751414489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJDOvPBrrF5J0oB9ou929TdF9QghUuaRWuqk9z1EFRQ=;
        b=Ei3zGffd0CAUi0JdPXqzxbClnhCfYc1T5ULnvSJFzrDpYkwX5DmDhMrJRWMZemS/2+
         ui0pb/+7q1hjkDBq8Z0hNQa4PgSub0CpWpdtoMQh4r4qDQrZ4mlwch8HaM0WQFD9R5Ct
         WZK6Cjrjp8yMS1o9TdBhDL6Q4CPt5R3loN4dpktQlfYBzLNkxzbwbnAULM4QnuZgOXsI
         Ex96b6+uo0POnopeN/XjArGPNS/lEKWdqZkPVXw20Jj5LvlhPrdWrCZ/Svn52Djt7RUa
         8wU9kqw690qgnr8q3JEoDCKpMcr4h16Of1DgT6By/CO+xbW+ghsyoNE80zfsdB2LHoIs
         +LLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjPE5o5KQ8V942JbraGBp8ZOgWFFw7BmE2IJt1N3F756dvHakvXVmf7m4/HwGQeZLIEMJLkz+8RF2t9So=@vger.kernel.org, AJvYcCX9FrAO3AVK8vL9dF2k2TAx7Wz4+ElunOSHk8KKcx8CRVYDNvzpnuD+ZV5dmK9Fr3SLSqN15opCVOGt@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyIK9Yb+ECz37GLmdZ0dDc4z1WS61Y92/q/2iiwAkqzGBpzTZ
	u1jg5WHecSR3bGMZzcSt0LdRegIkWX+X01Y9T3JFhW4V7uYpwCN6vdJU
X-Gm-Gg: ASbGnctF35LO3bqufxbIpnD2KRcbh1m2uJzpy8Mkh5e56GTeKTFIlthy1K1O4Y2qkSi
	sSN67bLO9A5kM8/ZgcT808wPqVIqnGJWsBBhZz+J9uSavOfyC+oghjoFm92zb+7SQJ/dGWAOqvB
	bbp3Dg94mEQjnor2Q4vKy8kF+H0q/uf0dK3iDihfZbFiWUNAWoQtseB1mrK9o4YZ/GebINCEphz
	/g+4oXwFfRmGAb76MRJnXtpDmHN86itV8sLeV0pydlkl62bjTFoaxc8JSp03f4GM/Mn/JhCt6fp
	PajSVDUMNrS5M5UyEn32sexeggH2hv7iNk8wIpvkDI9f3Gs1qgfZenBqFvhjSs+qD2u1OPOuWMt
	tk7gzwho8G+pnK58mJ0kNqtNUba8fukc=
X-Google-Smtp-Source: AGHT+IEzUM3ENqNgr3GJQmkdnfKonc2YVBR+RB9+F9FqmI15fNLoWqHb0YMzUCY9djuhtycpgDYDqg==
X-Received: by 2002:a05:600c:3502:b0:442:f482:c421 with SMTP id 5b1f17b1804b1-45381ae48bcmr6039245e9.22.1750809689237;
        Tue, 24 Jun 2025 17:01:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a6e80f27besm3091909f8f.57.2025.06.24.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:01:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v16 1/2] math64.h: provide rounddown_u64 variant for rounddown macro
Date: Wed, 25 Jun 2025 02:00:38 +0200
Message-ID: <20250625000059.20040-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is currently a problem with the usage of rounddown() macro with
u64 dividends. This causes compilation error on specific arch where
64-bit division is done on 32-bit system.

To be more specific GCC try to optimize the function and replace it
with __umoddi3() but this is actually not compiled in the kernel.

Example:
pwm-airoha.c:(.text+0x8f8): undefined reference to `__umoddi3'

To better handle this, introduce a variant of rounddown() macro,
rounddown_u64() that can be used exactly for this scenario.

The new rounddown_u64() in math64.h uses do_div() to do the heavy work
of handling internally all the magic for the 64-bit division on 32-bit
(and indirectly fix the compilation error).

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v16:
- Move to math64.h
- Fix spelling mistake
- Use inline function (to follow roundup_u64 pattern)
Changes v15:
- Add this patch

 include/linux/math64.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 6aaccc1626ab..60cf79d0d7d6 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -370,4 +370,20 @@ static inline u64 roundup_u64(u64 x, u32 y)
 {
 	return DIV_U64_ROUND_UP(x, y) * y;
 }
+
+/**
+ * rounddown_u64 - Round down a 64bit value to the next specified 32bit multiple
+ * @x: the value to round
+ * @y: 32bit multiple to round down to
+ *
+ * Rounds @x down to the next multiple of @y. For 32bit @x values, see rounddown
+ * and the faster round_down() for powers of 2.
+ *
+ * Return: rounded up value.
+ */
+static inline u64 rounddown_u64(u64 x, u32 y)
+{
+	u64 tmp = x;
+	return x - do_div(tmp, y);
+}
 #endif /* _LINUX_MATH64_H */
-- 
2.48.1


