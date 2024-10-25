Return-Path: <linux-pwm+bounces-3859-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7F9AFC11
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7CAB23B06
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846A1C4A3B;
	Fri, 25 Oct 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmYKRuuW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF981C4A26;
	Fri, 25 Oct 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843626; cv=none; b=liAdcPTM7FyqDTn0GuAaEWiU9irRkwHODWdxlsk8o37Rbm/yy94ZCsZx9k4LjudUY0+HzlFrBLLuXL+IrYULAjfKagUnyXNQmeZ06DfxtIAsmDZeN2beJJs6dKAA3EHmv+l/AMvMDRvlIBLQapC/CseElhFitX7g2s/K0tdFol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843626; c=relaxed/simple;
	bh=6PhqsK4X0scvxeS2ZPiwz4VbAxk7bJYz4NaSrXbewV4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZVXYMGgtsv+3/vtlMvF0CwMpqmXmPMcw957sWeW103aUDH9KYSSjZX5nf5RQ+gdbfkb3GXnfqLNzHEpxKtnlwF5J3X93PPplNG9Q1LQE1JlvaATRWsOvVAqf1/iQOrjBZgUnJOxTWNY0fqHoNMO039EsUFu2VrgV5O5WPYjVXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmYKRuuW; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-288d70788d6so970965fac.1;
        Fri, 25 Oct 2024 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729843622; x=1730448422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCanS7lm2oIK9WyJeeAEIKg/+DUCUltSdlV8tSxgaXs=;
        b=DmYKRuuWsbFMkve21jAPnoN4111wu0Ug2Bs90uUDcYZvn6R/qaQ+MVuzKuKKs9GeUO
         P4yIHgXVEDoMRtaC0+OUaSajiRkm3PffVDuhGynO4VkcCAUlHeSzdPteDiYZljT6inCV
         WHr3KnzzVQu+8TLQ9xZ3jsZV5+i+LuTaCGSkAb12O8dik+hSZ6m2BW2jxExopgmpLwQS
         IpaiqybLd2r25KyQa89OnlWxwzqzhUsOnmGgf6nBCNz0pDuSAn4QFw91ZY7CI5azI6EC
         Rw8I+J7fjheQZVAGtVF1U/2sOcYJMss6noJVZgQ7gcj9lhlzSPaHDka0XL7Sqn7+cd0+
         C/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843622; x=1730448422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCanS7lm2oIK9WyJeeAEIKg/+DUCUltSdlV8tSxgaXs=;
        b=mJ42FuItIiQAXPnrGyo4LVKh91U7+Gg+A8bELkLKOsQGq5ykunscmj2i8PH/D/gFli
         Ji+1dL1X88vO7msDDNWBqmNp1lVS71dV+buDq2R75A3tAEoYSI1GvewAUAHgHnUqlFVQ
         3BD+q+StOmrEr42/Cg/tO0jsr/yYrCFrlS+aqeL8q+BtZrpL0IhVgp7icr8JHdSlvN65
         cS2eLwd9T66g8sPjX9k7vUUxp+Ma/AEHZnquzqxvcqRo2uQqTyNkC4jOq6N/pEWjEpyk
         kkEbA/fw85plsW5mkHr+WXwnIoZuieWR8BDmVH+NuvBCTyBIjLZyfa8UfQ33/7kyteQD
         Yzsg==
X-Forwarded-Encrypted: i=1; AJvYcCVMQhZYiJ9M/4PuMvv3pBHglLcxtvD//6NRijEPlfBKXepl7hENHxcbvRXiRCujmj0tvKNDhDpbXIeSzVD1@vger.kernel.org, AJvYcCVRSQgT9HC0bAf5ksHRYAYRCdWIXors8RAUNnXwCj3FywtJXbms9PuuUR2Ped4IJBXnLMMFjGHqgL9Q@vger.kernel.org, AJvYcCVwB3hKOOf23MTyBNb8Nb8sK7lSn/NEK58rX2rPe2oHRiDvGfQNW6/a6SCtePNfGtJaI6ylFIxmvXQ9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm286N3GOBj5PG/7ozmhEw2l/tkjHSfbidNEL/rnJUhXYkZwLs
	Ma4E6SLtYguDhFgJxVMKCQ75UJzfSSAeXXulIBU68rkkLntSy6Id0yRSiA==
X-Google-Smtp-Source: AGHT+IEWw+CFqp1TrLaz2UZqvWaNMZU4mMUog4jCovrgVt4urJ8rzGiEs9L4ZK07ucQAa4zt0NSGNA==
X-Received: by 2002:a05:6870:c0d4:b0:270:276d:fb54 with SMTP id 586e51a60fabf-28ced2eeec4mr4850317fac.21.1729843622484;
        Fri, 25 Oct 2024 01:07:02 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29035d20d70sm178319fac.8.2024.10.25.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:07:01 -0700 (PDT)
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
Subject: [PATCH v5 0/3] pwm: Add pwm driver for Sophgo SG2042
Date: Fri, 25 Oct 2024 16:06:52 +0800
Message-Id: <cover.1729843087.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add driver for pwm controller of Sophgo SG2042 SoC.

Thanks,
Chen

---

Changes in v5:
  The patch series is based on v6.12-rc1.

  Updated driver to add resets property for pwm controller node as per
  suggestion from Inochi.

Changes in v4:
  The patch series is based on v6.12-rc1. You can simply review or test
  the patches at the link [4].

  Updated driver to set property atomic of pwm_chip to true as per suggestion
  from Sean.

Changes in v3:
  The patch series is catched up with v6.12-rc1. You can simply review or test
  the patches at the link [3].

  Add patch #3 for dts part change.

Changes in v2:
  The patch series is based on v6.11-rc6. You can simply review or test the
  patches at the link [2].

  Fixed following issues as per comments from Yixun Lan, Krzysztof Kozlowski
  and Uwe Kleine-König, thanks.

  - Some minor issues in dt-bindings.
  - driver issues, use macros with name prefix for registers access; add
    limitations comments; fixed potential calculation overflow problem;
    add .get_state() callback and other miscellaneous code improvements.

Changes in v1:
  The patch series is based on v6.11-rc6. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1725536870.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1725931796.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/linux-riscv/cover.1728355974.git.unicorn_wang@outlook.com/ [3]
Link: https://lore.kernel.org/linux-riscv/cover.1729037302.git.unicorn_wang@outlook.com/ [4]
---

Chen Wang (3):
  dt-bindings: pwm: sophgo: add PWM controller for SG2042
  pwm: sophgo: add driver for Sophgo SG2042 PWM
  riscv: sophgo: dts: add pwm controller for SG2042 SoC

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  58 ++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   9 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c               | 194 ++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.34.1


