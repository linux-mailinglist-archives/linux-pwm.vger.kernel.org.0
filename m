Return-Path: <linux-pwm+bounces-3577-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDBA997747
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC991C216F9
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB391E230C;
	Wed,  9 Oct 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q2PPMilH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB571A4E92
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508317; cv=none; b=mqfQpx7w4r9a4vylm5sLwA3FStBmmMukkEWGmMjRpJQXJaNV1CT2ywtG9mcmow2ShPV8OldZk6/SdR6myP4e1ppNDis6JI+AdH+2MUCRoNWQATyuEmEvkAOAKoWhoGnsoAJqXdP/bnpwUc6zpolfL81yHRCfoto76aFt5av/tP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508317; c=relaxed/simple;
	bh=OIMRLMXeFCj6wV1jO5Uk1ezn5ATX2tJzF5dJAU5Ywpw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gpmyE8mZfDToFHW4ICKvWjVbt8bgdxhh8RXSD9hX2ItWms4WDcyNivoQYgad1/LlE3n0CfThGO8rUGhCNHqiAcBpMmP6S6Es6M/un96+f+I/sg49DRslO6dOw0qoD7Fp0Kc8ko7dXZ2TwIJlGXA6LIN/zQUBBqeft8YSxHTGwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q2PPMilH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-711009878ccso172397a34.2
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728508312; x=1729113112; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2W7U61TIAOkY6yspEmHuXDamthdmPXi9oH2KLwGRAg=;
        b=q2PPMilHBzo7BXTnjw8t9MyuoAsLe/J0gstJ4LyLmjy75RGg6eSSLk93H6Mdhmc1WJ
         MfoThBqdIfTeU4ITN9uK+K0a2eFCn/Xhw65L3i+kkifRraPZ4at4Q1YafvwUt+UkgO8O
         3sIxOvhmGyOAK/WlGDfS8BaAsAaWKIQWklLqktDHKpLXAP3fr/Vd2bhTAw5Nt6Jias7M
         sWwUoCoGFLwkzZGYUe2NEuRt9LdtpQrSOUAznRQ59we900Hf/aC5xy3qIiTetj+GG+Ch
         8sNqxp4w2UMyC0H9yaOU5hHJvNCO3x02oPGb1eOvZo+QCyTZNdi/0fThGMzTcSm7o/lI
         Nsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508312; x=1729113112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2W7U61TIAOkY6yspEmHuXDamthdmPXi9oH2KLwGRAg=;
        b=l8X1BAki95fd1/+HIEvfp2H9OXxP1j2QptK4foK3I8H4AFnOqSBbx7QfCgBID/+vBY
         h3k1lpXjnblLhv/NGUK8VkHJyQ9azFE5EbPVNcDfKDgOF+/v2BCCVrlzLX/cvzMBXDL3
         yeoVYpQnwrZA8dHoB2elEDw+85G9h6Kk7oBK1ftblC7tZi83aY8Dhv4K7ledli80iksm
         An9ZS8sHgWox6YAafOaLMN47kKqaNAvnO4k/hYl42zLVYndq0KtzOFIH2riO6ZNUxDBz
         Extxy6IZ4//Yzv8cGR9hdYtg2WCqrVGGOmf67CgBODCo/il0cOtx2N8TCOnbSZWKaWM/
         Kb/g==
X-Forwarded-Encrypted: i=1; AJvYcCWMnKUesoi0kFeN8opFYavWpMra1MgKuCU25rZGJSES89PeD29U3zyiJ8dRhrD6Eg+a/qgwG5rvhJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZB5anHRKETB1BPTK5xIOwZsgyPjQjP62TtQvhlO/qRBSU5EiE
	84JhfwH2cwvDZeZhnEJYki9jjTVhGAPcsuJuhBOASnqvuKjXb4czdGbIC/AuOSv5vjqRC3aGF+9
	5
X-Google-Smtp-Source: AGHT+IERMKAY/i/Bay5AWlUQZb+3SD6ejnrXKYWZFrsF6NAF3gFaLTIdl9Y1oX3x4Wp8HAoBN7sC4g==
X-Received: by 2002:a05:6830:490e:b0:708:d84d:f62a with SMTP id 46e09a7af769-716a42164d0mr2922278a34.22.1728508312670;
        Wed, 09 Oct 2024 14:11:52 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155688a874sm2455747a34.81.2024.10.09.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:11:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] pwm: axi-pwmgen: always enable FORCE_ALIGN
Date: Wed, 09 Oct 2024 16:11:48 -0500
Message-Id: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTxBmcC/x2NQQqDMBAAvyJ77kKShoL9ikhZ4yYu2FUSsIL4d
 2NPw1xmDiichQu8mwMyb1Jk0Sr20UCYSBOjjNXBGeetMS2uvy/SLjcTK7LSMDPGJQf+0CxJMcT
 Bm+dI/mUd1M6aOcr+f3T9eV7l0KrAcwAAAA==
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

When using the axi-pwmgen as a trigger for ADCs, we've found that the
default behavior of the PWMGEN IP block is not ideal. The default
behavior is to wait for the period of all PWM outputs to run out before
applying any new settings. But there isn't a way to block until this
happens (and even if there was, it could take a long time). So the
pwm apply function returns before the new settings are actually applied.

This makes certain use cases impossible. For example, to use the PWM
like a GPIO to create a single pulse on and off to trigger a single ADC
conversion.

The AXI PWMGEN has a FORCE_ALIGN configuration option that changes the
behavior so that any new output settings (period, duty cycle, etc.) are
applied immediately. This can cause glitches in the output, but makes
the PWM actually useable for most applications.

Also, there was a naming conflict with register names, so there is a
preliminary cleanup patch to sort that out.

---
David Lechner (2):
      pwm: axi-pwmgen: rename 0x10 register
      pwm: axi-pwmgen: enable FORCE_ALIGN by default

 drivers/pwm/pwm-axi-pwmgen.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)
---
base-commit: ff25451372ee1aa4c4f4401dc96516782a00dd4d
change-id: 20241009-pwm-axi-pwmgen-enable-force_align-cfb403da4612

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


