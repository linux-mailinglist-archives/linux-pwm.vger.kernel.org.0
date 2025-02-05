Return-Path: <linux-pwm+bounces-4767-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A13A284C3
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 08:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B3F1885A44
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EB218580;
	Wed,  5 Feb 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZKMrglM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF025A647;
	Wed,  5 Feb 2025 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738860; cv=none; b=tyHzGkzpveDGHqkTC6yOwnXZJHrYZJbJfcCegSnsznn6BHzwbFinKgIqOgOvH/u+NTuFw1irDxqB+BhV0gsKEYsUJI1gfnq7xtqnGiNAKUE2+B/roSoLwAMNwazH0ZPmMsb34CGbdaQnIlJb/Tc3MpMMVhnrqsubuHASE211dAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738860; c=relaxed/simple;
	bh=7WjeZz4TO/UuK5w9UlH8RWVjZ0WWQQw3zyv05GSNR6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMqy3THPJpKfgHCzbqEbQufcK8/xqpzfp8Coyus3ng1mmQ/ScgXsRTY//IAkv2gW3tcy+JStGqUfzJcQbBmppuI6vAV1tlp4HiqDXpnbCs9JfDIDx3nMkG6Gm3qB3tUCKDsMEpNumGlDatZC15+sxUdIlhUdgqPNvvvQJG3uIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZKMrglM; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fa2685c5c0so2512470eaf.3;
        Tue, 04 Feb 2025 23:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738738857; x=1739343657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVz8hdajmeQn+sLRJ3LfLAYPYY16G3b35wwKMJMKlco=;
        b=XZKMrglMrIcKZ92aUDgXEA6zo1F/ZElB5gE6U0vs0qnpxHzSakFhCIMbX+gV9QLme9
         bjf7qCwTVVTkf4agtiFKTbuD/p6UArod18B+cxehLAUtBBvMyRXbJKsKV26oZs6Tlprw
         PKo6zcNStD+rD75lp/1mUT9vw5boKFMVQPwWV1NVsCEzEhyZylu3EySfC4rrbtITNL9g
         TvyiNwoTlvj9lM/IcQe/g05E5zQGRNgYAx40iWWw33wMJmuwk3W53n+Fondmo3mPYRJP
         eftDO5MJIV4RsL89AnZC9TePPRX3zeJ+uKYv+6Uo/N0Y9SaCgIojjLXHU/RuOvCLZIok
         6LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738738857; x=1739343657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVz8hdajmeQn+sLRJ3LfLAYPYY16G3b35wwKMJMKlco=;
        b=LlfCleuqyc88cjfF1CKfkUjPw3DfGdlNc/+es1w/6vUL8N+YHwaZzi1Wnvh0zEEY9/
         XIkhvpnuSGoVmzoTQyHhvcImKe2fYSsIqlS43kgSCG4QyPFUeWPpZ0udnqUBJvuEb7I8
         F5V7K+j3l+y9dnUdwbQydW9UPBMoZverRVfLsQiFP+f+5k6Ep07M3lGrb6gSusRaRFKM
         Dtm/DyUrWbxKPJjYFnSSNoF9crIsq631vH+VKr+y9fPwLyPBYLUvu4lwAKybrkp/M+UW
         K/chsdq7JFSErBUdys1xGt8r1azedGo2R69b+Nt68BxUKb7iyAczHKfT7Hq9yGiX9lII
         rLeA==
X-Forwarded-Encrypted: i=1; AJvYcCVYJN2hgW6mFFGf+I1PW7QI/6aVlE0dyfewMFqz2EG8d6n1FGlt1Bg4JzZ281rc9czUSLtQpwHt2i3hM6O+@vger.kernel.org, AJvYcCVwGiX1cjp3v80q2KCljj2wNif3u0IPQ1XJwTtrpCZJAsWdTfjF8Um9xGZFf0b3jXMiFIZ3XKQ2vNy3@vger.kernel.org, AJvYcCW1Kt0J2KnaVOi5DxwkX7xN6ZsIXcwdfuLNkFRreIKrUp0eT9r9iFRj8mWkMB89QcuDkCGCgNilWBE+@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyH8WovshNAaQUjPhPHZxG/NQe+frbzqjqqMcYbSM1zMKXEwh
	QKGZcOnQVsd7gCo0WHBXwMvMcNIUV57Cv+DIXPYZTEsnGJ8O7nT6fozSb4Shwl4=
X-Gm-Gg: ASbGncs8xo69JHguIS2+K+js3E67v8wWmA/NzWCHlSjUZMsaZ28aQxTyNRvfYHugNYl
	WYfTNsmiI7FYKYLdSI16pmu7FgE/oXv260Q0w1YMS/2ibpVxQLhOwnwoMng0EhXeWdybgRBxq2U
	jDGLqC4CrVG0lh1VNBKMLY5kgKOC/+expCclCCPVFrPLFk3W7Y4JFuk5CE6a2mh5bI68iKXBxbF
	msJd+f7ib6S998sUndua3Ma260dqrrGwplxeg2iedpym/Bu+7VG8WfEIvJ2x7glC9mvYJ6acUWN
	xiU0XLmtnK4z7Hzqu8evmtCdmg==
X-Google-Smtp-Source: AGHT+IFsHiem+4btGG99h0d6BwMEp2mzewnRG8Nfz6GBsGDnx1ZgDacLy7O2/NhwKDNQhLK60akjwA==
X-Received: by 2002:a05:6820:1992:b0:5fa:73ed:de8 with SMTP id 006d021491bc7-5fc479ce7demr1475362eaf.6.1738738856694;
        Tue, 04 Feb 2025 23:00:56 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104e29b7sm3598247eaf.17.2025.02.04.23.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 23:00:55 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/3] dt-bindings: pwm: sophgo: add PWM controller for SG2042
Date: Wed,  5 Feb 2025 15:00:47 +0800
Message-Id: <d739ea5a1bffcf762248efbe25fae9b9fda6f452.1738737617.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738737617.git.unicorn_wang@outlook.com>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Sophgo SG2042 contains a PWM controller, which has 4 channels and
can generate PWM waveforms output.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
new file mode 100644
index 000000000000..bbb6326d47d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PWM controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  This controller contains 4 channels which can generate PWM waveforms.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb
+
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/sophgo,sg2042-reset.h>
+
+    pwm@7f006000 {
+        compatible = "sophgo,sg2042-pwm";
+        reg = <0x7f006000 0x1000>;
+        #pwm-cells = <3>;
+        clocks = <&clock 67>;
+        clock-names = "apb";
+        resets = <&rstgen RST_PWM>;
+    };
-- 
2.34.1


