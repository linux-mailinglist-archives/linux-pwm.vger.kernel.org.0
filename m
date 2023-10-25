Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C427D6A9F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Oct 2023 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjJYL61 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Oct 2023 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjJYL61 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Oct 2023 07:58:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0FC137
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 04:58:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso78367681fa.1
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235103; x=1698839903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfUbynUkW0A2o7wHLTAuig9K/lMD2l5OcDGR5b7mo8I=;
        b=HYyYR0uMNwcSdS9CVikc8iJGHfOC/5jShavalbMU6vJRt68ZUt1rT8JKwOLZ/49sJ6
         gvVZsnQJ3RkhSX+MJS8RmKe8iC+jl60pBcvHL1es8DBpk7oTMPb1Ak23xItagqxMm4o3
         lL3yBozDfXqWPhSryx2B9E8mASZUyY1YToXF+2JVIpxvhwAn5jkE7+0xpiUzrF12ijrR
         88ZBpJAgvjfqUAV//vCZv9qmm0Wpw+MskL4OfMNext53DqHEQtCrBhuddDnF9Ai40HFr
         O6AtZwjbe92j4N/66Hz3qHQ9eDmA8cyWaNp8F7NETU4NFSDfVXtyET19GvP5IMOIVML+
         LCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235103; x=1698839903;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfUbynUkW0A2o7wHLTAuig9K/lMD2l5OcDGR5b7mo8I=;
        b=AVBYPjt+3KQYUSPcq9CIfZ5fcDGnyn3apEBDsn9ijdmI7uk2u4dhyc/gK3EMU2kObk
         v2FD5e6AQ3q/+1CPwAQeTz8sVEkRXgXAa3H/8Fwe2thEfxFakTLq0aRyLCyZOXZba4ZE
         tTXRVnT0XntmFldZg1nazI64YvY5Pf3l/l7NPToVQ+bD4XtzJtsJ328NXBcNZwjCKW9P
         LCpyinOpIYKbFN7ohEjH0uVodicEBofFJJb/DjuklvN0YchDcrh/BNuuNmg3vT3jWoq3
         GUv1bM4uc1YK0Hnkz38nPvtLyHN/FRXRIz/G2Nd4/UdoZSs52CWIGXdoSc55m/0ZrSCn
         1uQw==
X-Gm-Message-State: AOJu0YyhisKYHQLV6bJrf7WvTYEmJMXp9lADqRlID96vYnycjhgdtxUr
        0mpRtwOOL7gWOPk2k89V6HyUAg==
X-Google-Smtp-Source: AGHT+IErfEwam0o9Z+S9MmPXBYGKaBe2GqXi5WgE8PLd41wLN6ZsTrlS6woDbrEBK+9ZpW85UKerfw==
X-Received: by 2002:a05:651c:c8a:b0:2bf:fa62:5d0e with SMTP id bz10-20020a05651c0c8a00b002bffa625d0emr12084791ljb.2.1698235102948;
        Wed, 25 Oct 2023 04:58:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003fee567235bsm19103191wmr.1.2023.10.25.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:58:22 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:58:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2 2/2] pwm: Fix double shift bug
Message-ID: <447a8e49-ee37-4fde-bc4a-ebec3e37a311@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e031db45-add0-4da7-97fa-dee95ee936ad@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

These enums are passed to set/test_bit().  The set/test_bit() functions
take a bit number instead of a shifted value.  Passing a shifted value
is a double shift bug like doing BIT(BIT(1)).  The double shift bug
doesn't cause a problem here because we are only checking 0 and 1 but
if the value was 5 or above then it can lead to a buffer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2:  White space change.  Split the patch into two parts

I didn't put a Fixes tag because it doesn't affect run time

 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e3b437587b32..cda3597b84f2 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -41,8 +41,8 @@ struct pwm_args {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED = 1,
 };
 
 /*
-- 
2.42.0

