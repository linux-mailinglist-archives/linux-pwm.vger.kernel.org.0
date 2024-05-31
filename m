Return-Path: <linux-pwm+bounces-2301-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D58D641D
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 16:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950DE1F28154
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D316EC12;
	Fri, 31 May 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etrY+1R5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CAC16D9AC;
	Fri, 31 May 2024 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164735; cv=none; b=Xlf9mPYPCUhjoOnF/JA5N4LNA4yvDsntXc4GRDkdGrl5JtTSjvMJfI4zR+nUaDWtf8G2ESFbU2NCiYNA0VI+5eLXZ/hW0ngfy+w0DkQpVKNj6w5JM4LXqabMQur4/C4iye38aO69SSmBNwkLnulLmcpfh+wg9DM758P8FEB0hE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164735; c=relaxed/simple;
	bh=XLqZFjlEoqxOyPl9bFUh7Jqa2hmuAmBz32zTzjZrBpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyYEaKIYWaXc8LnJ6aiNKx4oWLHfyX6T/CGxqMXV44dajr67AkXsie3+qQzAwNYQC0xHxEeQQou+uJp7tDxT/cMlRDvzGb1y3Dd+5FOsCbNjhIV2RaGI3RubGNvxs6Q7oERM9rF81SVYbt7CaVGIaJ/yLLrABf3zPS1spGAB5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etrY+1R5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-701ae8698d8so1701899b3a.0;
        Fri, 31 May 2024 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717164734; x=1717769534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykvp/0wm2JKYn1VhbfeNlnxDMxT2k1KfiM797oH+i0A=;
        b=etrY+1R5LOUSB1HRNYYB/4c8RoCUD1HHCRZQ5PmTZiDeJdWD6HCfVAZKlx3pHJYSQ0
         SQgHdbsqaQOySbeG5tv01869eBF0flTdOKMUQLMbRxhyfs0QpMeLgjIgZYTcxRoqPHXa
         UQccCyK/8IiIfN3Lw7QozOKp7ryOim25M4GmBEb/KeSmbNRUh/pHIsGT9ru2Qwp5lwh2
         kI4U6mJbCRNp4qmzzox0qwfiH2h+9h3/CjY/dhHn8snwjC7IncYl2AVXuabxHS3jbx6V
         Gx05VQxHAjgREq/O6jM3CWoezVidQKxoQC3JJr7I15usUEwwifxjwMEZMGu5yA+4YOTC
         lOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717164734; x=1717769534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ykvp/0wm2JKYn1VhbfeNlnxDMxT2k1KfiM797oH+i0A=;
        b=iv0hqqewBZLg0sPJE0nad5fOIDN3mPN4Hqfvm/OkzCBqFZeIHUUz7C/kdxcD1Ox9n/
         yOkaHfaFVIurmWkvsuBVrw0i5DyfF2mYvxeyqsWuf5/qfoN0UFEV2NdhMCr2K7pRzmsa
         9Sn9c9/oTA9hoMvyRLOesYaCK2sxfqYQpKpBtYUr/eEUUtMx3uGKaiP5BzG1pn1raF9o
         uuo6DCuZRtZx/L72H40bMdsdmui/RP0ZGB+b6nHSdX+axEDRi+zsooTKfgikxAvkqNqr
         97S+BCre0GqEGjTVxScrrICD0vQ294GoYAGr3dOgbcJAfCjBFIDnHJkj2sCaLBPZyMiS
         LKlw==
X-Forwarded-Encrypted: i=1; AJvYcCV9JtLJ/RB8e3sTGjY9NZFu2bXEOYor/70iJ87RuzcWJ21JcKutpmnKtv9I1cd3VZgxGIvSOpww+upoZ64BVJaxK4rjD22flENU9/0tKYMCcu75zO4exHx+AbYOecCK6YWf/3x0GQ==
X-Gm-Message-State: AOJu0Yw1/2r2tZ4Eu4OK8Vbmm5FoBBjOXex4U2poakwQuUrso+d6R4bX
	dyuagqOpwIgaNZ8TpTNHHInb5PtCJxWg1MzhOnDd72EHXozsPBtDK959b68G7/8=
X-Google-Smtp-Source: AGHT+IF9QK1BGyLlONfFHI2NZ/q0q6TlP168YBjy8Girmb88VacbO8e/f7OnxTM2vSORBcmJgAyihA==
X-Received: by 2002:a05:6a00:1785:b0:6ea:f05d:d2ec with SMTP id d2e1a72fcca58-702477c2abamr2233447b3a.2.1717164733748;
        Fri, 31 May 2024 07:12:13 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b057besm1418103b3a.162.2024.05.31.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 07:12:13 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Aleksandr Shubin <privatesub2@gmail.com>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/5] Add support for Allwinner H616 PWM
Date: Fri, 31 May 2024 23:11:32 +0900
Message-ID: <20240531141152.327592-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Allwinner H616 PWM, building on top of Aleksandr's
Allwinner D1 PWM driver v9.

Additionally, the 4th and 5th patches implement the proposed method
for delegating the clock source and DIV_M selection to the Device Tree.
While it works well without these patches with the original behavior,
applying them enables fine-grained control of PWM resolution and
prevents non-deterministic behavior dependent on the enabling order.

I have only been able to test on H700 (H616 variant) using an
oscilloscope. I would greatly appreciate it if someone could test
this patch series on the D1 or other models.

Regards,
kikuchan.

Hironori KIKUCHI (5):
  pwm: sun20i: Use devm_pwmchip_alloc() helper
  pwm: sun20i: Add support for Allwinner H616 PWM
  dt-bindings: pwm: sun20i: Add compatible string for Allwinner H616 PWM
  pwm: sun20i: Delegating the clock source and DIV_M to the Device Tree
  dt-bindings: pwm: sun20i: Add options to select a clock source and
    DIV_M

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  20 ++
 drivers/pwm/pwm-sun20i.c                      | 326 ++++++++++--------
 2 files changed, 201 insertions(+), 145 deletions(-)

-- 
2.45.1


