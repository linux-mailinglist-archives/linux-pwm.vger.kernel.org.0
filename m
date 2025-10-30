Return-Path: <linux-pwm+bounces-7566-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7890EC228D2
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA31234F12A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCF30BF68;
	Thu, 30 Oct 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ubrpQsIU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7325DD0C
	for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863145; cv=none; b=gHmq1YXHVUlel/rqQrUqpYJZS5wjFmIlunXkUeEYdCAfsTVUJRJXPs021b3YrLD4NNLN3JFnYAKUSSlR6zu7Lqq3FiYX9Hp7YRO6EvPdfPvGinZRojDqEFqFwzj7341UJwRIYE2GmLbDHaFEm4Td55LZivuSe7aNDnICOV0+D0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863145; c=relaxed/simple;
	bh=SYIUerC/xexWng8EppMsWh0BUF/Bl5ux1CEatheccIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=INM9su6AOdsxZhCy4aKHM+ZVCf2fAl7h0V5yeU5hGR1ZYYGiBzXdqplWE7CVv/wHAd12LOoEqkop5kRAJH+uTcQsZy/LuS8JXaJao2EmtcHenEJGojaMHQa9nqWWVVFhADMoiZmGAa5GsRS8K3gkdEzzsUOeW6cLlriVUSTrU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ubrpQsIU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4539dddd99so381154966b.1
        for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761863140; x=1762467940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vuV/8yNqcCPgemhGCUUQBQDrlCH0iJrd6i7TcBGCZU=;
        b=ubrpQsIU55miACbVaHSF9gNEgZrZ1Ug0JtXiBfZo0PibiuNXhx7E5srfJhJUOgqu78
         1LQqBsgpC4o12BG5jqM9QlpkYiRk77/BRbt72C57SqoYmCuIvI6DBNK4jKuN9AOWPYZ8
         rl9CZczZbfaHmtbsXjytjNYsbnSgeegAIWfgy+ukRohhmAxX1Ke+q0z9e0cO3kAtfTVK
         QL/iAxWSk0A5Qfh/j8F4P4FbO4d3BNwtxtpbib+RZYbkXzFmCOhL4aEWNdehvZY8HXxg
         iuw2QAtSWTgstDeKBzmSjgQEE5pcJvSLmarqW+ZKLljSFO2jG8JCHjFWFNQhxaFnm9Sd
         6Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863140; x=1762467940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vuV/8yNqcCPgemhGCUUQBQDrlCH0iJrd6i7TcBGCZU=;
        b=QpXD/XFFeI1C7nUXBs34oXLkD2ukVy9UgdXh/1wT1IcgS8WfrfUNV1hwpsz9tpXswe
         qaKkRspXOQnC7pEFcJUglXp0nXwu3jeddNRu/ZKyDqSbeVijjyzzY/KLyfUQj+Iri+Uc
         dt2xKgJY2WgWA7BGZg+S7teGrrxWYxjBNLnd3zXDW13yOdQc4iCiRhymf3PlhpuNVQmC
         F7b2KxIHxUSVxd6UqRkhNJtMP6IeCAloZsB5fiGfnDfm/bqkVdX2FlU0kHsIxGgsvW0K
         otW9dtUlTBmu1TNi29y6U8wbl5m3mIPC1TCjlG+IY/r9Xo5sLoaLIABHg+m+XlLwXp4w
         Z4DQ==
X-Gm-Message-State: AOJu0YwsZc30ImkrUbKS7SS62igSO54lrDysm8kuou6pBrYhebqSaB/C
	Jc2usPHmLG9ukskzKEsjQNPFycYy/dH/MkwiWkAfGFu2kpaxU7yoE365QKFSSZvwMBc=
X-Gm-Gg: ASbGncsfwmOhed4Ud7+ky3QwppS/2jRrXFct8iqsZ47YqMebF1SW0/nyBbpGGouA8B6
	KTR/VXzrTOvZaeZ+q1MyOe1Of8XchzMUK6R++/582U1uoc9D1dcunuaBq/72FzlDdmcOjCEIsjn
	IweqSnNAtYQIsmlAqBtgcTrsJdMZ22GhAuo2j2/MFFUkDaHiFsO6ppquY4HgCU+AdIsBOBmH0g0
	230rP6e2FOcwVKIFLenmrAsKt5g4P78mpYMYVmf1Pz85OOV07MnJFVb/eAERhFm7oXL319zabM2
	CNWT5gh//CDFejO/yf7lJ2nzJuUwaEXRB72e0vlgnMjdcl6Ul86sX8WF0Z+S7AEet49mXL92NOh
	4PqV0kfFGG8wQhAj8eXWoyXbvlzBc4u6nkbxX6L+/PTPjx9UcMfN6CluJa6mBJFpWDQHZd+K1+v
	310mAR5Q==
X-Google-Smtp-Source: AGHT+IF5SUMEmxJ7sHz5EU26ysWE5fSSIeUi/liwYBUEkNzqfcfYDxvn9nhf0+F8pjiFc45fRSt38g==
X-Received: by 2002:a17:907:806:b0:b3b:82ee:def9 with SMTP id a640c23a62f3a-b707083054emr117347566b.53.1761863140409;
        Thu, 30 Oct 2025 15:25:40 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7044d00de6sm579859366b.74.2025.10.30.15.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:25:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Julia Lawall <julia.lawall@inria.fr>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pwm: mediatek: Make use of struct_size macro
Date: Thu, 30 Oct 2025 23:25:27 +0100
Message-ID: <20251030222528.632836-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=SYIUerC/xexWng8EppMsWh0BUF/Bl5ux1CEatheccIw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpA+XYSVrbXsDagZh1G/OShMN8OLLSgCz++eV/0 4cjDcAPTWqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaQPl2AAKCRCPgPtYfRL+ TqUZB/9yusSl/guKODh4FsI0I+VSKcrmxssTgz9GdsZBh4o+ADFSw6swjRwKMmGEQovx/evZ0n2 ckY5v3yWkiu4td18CXVksMoUPZNhz/DFtmyjkx6IezcMEYhEeNv39mSbfDVy6r+YvKDZYDZF93c BtFVfvL2givWJwEOF1ZEoOPuy5Zej30p40lSSb+x+NUOy1IaQXsa2olJHZIfQe9ZoTZAsjClru6 fA89b6jO2Kw0Z9sFzSzihGGyH39655BbMp9d1BKhMArWNy8ANoWx7MvU/88ZBgIb+6ZuKNvKMlc lPEZp4uWp/Pt4LHbAgl3TnIZw+BVLw/FrcunXV613rpsopxj
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

struct_size provides the size of a struct with a flexible array member.
Use that instead of open-coding it (with less checks than the global
macro).

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202510301753.iqGmTwae-lkp@intel.com/
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 4291072a13a7..d09f2eb4fb24 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -377,7 +377,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	soc = of_device_get_match_data(&pdev->dev);
 
 	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms,
-				  sizeof(*pc) + soc->num_pwms * sizeof(*pc->clk_pwms));
+				  struct_size(pc, clk_pwms, soc->num_pwms));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_pwm_mediatek_chip(chip);

base-commit: 27a8bb33b660614184b9382c146afd2ebfd7d7b7
-- 
2.47.3


