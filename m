Return-Path: <linux-pwm+bounces-7062-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D450B26F11
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 20:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F531C206C1
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C87723185E;
	Thu, 14 Aug 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="difLrOJh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72731984B;
	Thu, 14 Aug 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196881; cv=none; b=vA5PKFC2LRMDKhQ6i0yAQInqbHgCWwut8+2owV6WABsKQN+qnImoblZZuVIGt7MBCEsK4GHPBofLW4Dls+9nMP/ipDF9Y+ehKAEbqqisWo5qJDhz50iqc2cz0SDVHGrLBLozRsO9Q1XlEUpRIH33EFvVTNJju8koanrw3iKxUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196881; c=relaxed/simple;
	bh=20WPmpdoG8uG/s63QY9KzYtV0P+L1dCwey8MxztMAfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlZViCjI/b8Dje5N8rgvPLrd71PRVYkGGsY9PUAz7XjlVf/gbPjpZUoDoB7R9b/T9S0eb0E3K67vP3TErkT5l4JIvyxBJe0+sIaLpgX0e0A5T8Hvdj5DVhaDSv+Spxvm0GkUSWI607vTMv/YpCtuzbDBWaAhTExRPRD0DgorC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=difLrOJh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b00a65fso6603075e9.0;
        Thu, 14 Aug 2025 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196878; x=1755801678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRvjVv+xI3Crcmlz30dpeemlJT1MQZGfPOfm9qE9Vfo=;
        b=difLrOJhd8QFwh0S5VcDdHYivJnVWDhq7CJTWnbcQ+nELbYOoxjK/WNNpEv4ros0eC
         Dc1laT2AmHl88e6kK8rhZYAN5+pAKmh9eD/+yaWG0J6JJlj/6csXBSKDm0xgAtTCT6Ra
         4TMsvMsyn/sRhtySxeBbIMr+Fgu832vxe1H2T7IniM+IO5PJ1+K0Pz9CUCf+OFz+KSLa
         BYrwcfuXx9LfYdtNvYMe+glYhOxMJ1CcC1XyUOJJO7DhsurFdQymp6XeynSkSwzfMH9s
         uXdCrbjVhP3tBjhOa0NeuKrfTw3yLhsSLbQB5NvI1RR7hf7JfbJ8jtqu6lX+fWPazl4K
         O5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196878; x=1755801678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRvjVv+xI3Crcmlz30dpeemlJT1MQZGfPOfm9qE9Vfo=;
        b=fKIdBTjqvGLXvsyXkFYdY2ny9OyecmNIunpg4gewE3SJPZTEx8g500mjhTsSPikE2J
         UPcVzEWZcRqjhwo9FgksXVl7afQsCu7qK+MNPsZX2EgtXmL9RlouAIDWLIZ11JAp6MqF
         NY0CYxdBuHz96Bmqd7mzj362XYfYmUKLKHArckd6e9ZSXqOMlRoLxKZA2EaSKZ6iFd0C
         16d7lZh3RTpfZG7uNknqlrzkkiQ2PX00XKhvdHzXuvxnUN2BQSeZZ19AycpOKT+Dxc/K
         fCHGtxtd2St1ihGE5J8mgDdGUGteqLgfZc87fwoYavRpBddW1g9SQigl1EAZ1uksOlmA
         EvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV59D+Um7h1BsAkyFQGFYme4IP/s5ugTciRIjAWSB/WZc6CN8a4rODltxDsRzPnApqx2Uzuvn8+r6A9/8tn@vger.kernel.org, AJvYcCVhx/E0S2mZ8V2toxHrnIabbj8WmcWdPo+XOLKfL1BhZFrFTaUT0xNPAQweGvZCzmuoQOg1sxYr+ain4UGaUxAuYFo=@vger.kernel.org, AJvYcCVoX96bi7yayUgLbcuARpTevQ1p/mnmToLDnblcORqbjKtgmeO0LyVGajX2EnKsK0xyhBW+Gr8QNhej@vger.kernel.org, AJvYcCXE8rUsSUgKi5LMN2ObPvOWalS87trwijF4tyamFYjF1nHJYudt4Vubq9DhLr0lyZPbeoA420HRKnPF@vger.kernel.org
X-Gm-Message-State: AOJu0YyvE4pgPYnEmqrCT6QXGYh9VlaqJszSRYwhX1hH3rItHOS8FnDi
	7GynU2g3s7+qrIa3hSazt3boUzMNGotzHZUITw2YFZMqtgzDRCdnCP/N
X-Gm-Gg: ASbGncuAJe3kE3h+FBZoQpsVQvwoPVOGlNoq87Vz1pm/UIgzVFFksHvGLwAH6J2WOEM
	vCJlSDHlCc0tvXtI2M87IatUg5h7waoSk81DhbVq3kKc3FiT50Q32SstawnP5bt7XSNNqwM9bo3
	m6DkbFLP8EOxyNufTJR4gApf/88FXN7fcr8B+9PtGQxw6uyyMIKBTnpQGxdAi/STfEpLd3VGq6D
	hJpqnDeIp9Okl0CSYZ+Yb2jfDec2IjtIrum8bgUja+XYLtwNmLPZBPuFuRQm4DJCt0saSbz/pEC
	GZWYG1RASaZHq7NZ+zTUjYeghyOD8qemRx4507rkPNGa9vNwREGiAmQXShk8UhjjFlNq/tOyWPy
	YY5qZbKArryyiQCSE/EiNcBVwaAXAiQ0Y8qnK1Q0JCbyP6ZmTGcXFc+p2vvQWIrvJ72K32A0xHQ
	==
X-Google-Smtp-Source: AGHT+IGoWdhed5137Rxqqim3wIlG+P7n0VC9bMq+ooSXK7U4H7rnbQxmvbsbWYARQhbuVe6RR+mLkg==
X-Received: by 2002:a05:600c:45cd:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-45a1b649a73mr45325085e9.16.1755196877972;
        Thu, 14 Aug 2025 11:41:17 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm53744383f8f.40.2025.08.14.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:41:17 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/7] Add RZ/G3E support
Date: Thu, 14 Aug 2025 19:41:04 +0100
Message-ID: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

This patch has dependency on [1]

[1] https://lore.kernel.org/all/20250814115022.73732-1-biju.das.jz@bp.renesas.com/

Biju Das (7):
  dt-bindings: pwm: renesas,rzg2l-gpt: Document RZ/G3E support
  pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
  pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_factor variable to struct
    rzg2l_gpt_info
  pwm: rzg2l-gpt: Add calculate_prescale() callback to struct
    rzg2l_gpt_info
  pwm: rzg2l-gpt: Add RZ/G3E support
  arm64: dts: renesas: r9a09g047: Add GPT nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Enable GPT on carrier board

 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 525 ++++++++++++------
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 184 ++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  13 +
 drivers/pwm/pwm-rzg2l-gpt.c                   |  93 +++-
 4 files changed, 633 insertions(+), 182 deletions(-)

-- 
2.43.0


