Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15717681735
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jan 2023 18:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjA3RFT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Jan 2023 12:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbjA3RFQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2023 12:05:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD240BDC
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jan 2023 09:05:13 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p26so22491361ejx.13
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jan 2023 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsS8as8m+O/3YpaRzTVssIrBY9Y4e7Wxy3qITy7Up+8=;
        b=j2fmE6kUhrCNyiusiMXxgxKh/rGRmSds3s0JbkQeACwcuPMnsY2of1tBh2l2i7kFdE
         cnoYtLYRSzNr0z5kY5ETCq/uKzU5MqQSwxSEs1SGgkTu32WTP3ydqaSB56TW/sHG05k/
         yWVqqsWQtOHAq1gNH8GmVRz0vA+Jsfjia6Q+xkKGp2xOMazdktDWx/0Y2YQ170FWrOCc
         892uRh1x4QrXoEPxK9rwwuncGjSuPfkVIr0x2auv2zTz3lZ4VerdqPnBHYRSqgX3LaZq
         zwyP+RPgO7YbTo58GbnqGgN1cPSVRVSs56aLyGwRnGvSKFK+hqMWPDxg/JqJgmt6TgjN
         /QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsS8as8m+O/3YpaRzTVssIrBY9Y4e7Wxy3qITy7Up+8=;
        b=OUnJ9DzgGfTxgW7yK5zd1bXfAf8ZBnKKh/cUcUjk1/u/Y/Reu0EoKrQgMEqnDZ0sIy
         8HhPQQYzhoIlgfG15Ncwgq4GcdOnOF8OR7WgmmlTAtuR1izmGdzTSjS4o3dAwUst26v6
         Bd3k5KXGTP9c3/1qcuDdZRkkych5PPgyL/eLx78/rNY0pe0ckb5J4WQfinY1PzDJdK27
         wEkj7GEuFK6vGn2BkwiAXPWawUxDVPDlMGMy2aqcd4SY2sMqf96QDvVhun3qAcJr3EKM
         Liy8G8CmKdCtOYUpxO01KVbU3hu0hcjyuZ+LDqJgFV5phnlggeNT/ndZ4bI9M6hcfK8j
         7qYQ==
X-Gm-Message-State: AO0yUKU53kEjYD2aIpfyFTyIxLVrA4zYJOvHFfxfbFOF+xlDTlSl7MsI
        x6U0AlMHSEYZuzPVUOEwCiA=
X-Google-Smtp-Source: AK7set/ED30L3iAPXC3PeSWrznrn7lXdZKFvjjOmpu/bnaPpVv6wB6Ig1WP2+7FqhynRHXPKUeCf+Q==
X-Received: by 2002:a17:906:a009:b0:879:9c06:c8bc with SMTP id p9-20020a170906a00900b008799c06c8bcmr229353ejy.15.1675098312365;
        Mon, 30 Jan 2023 09:05:12 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t4-20020a170906948400b0084c4b87aa18sm7049538ejx.37.2023.01.30.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:05:11 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutonix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: lp3943: Drop unused i2c include
Date:   Mon, 30 Jan 2023 18:05:08 +0100
Message-Id: <167509829704.584618.16269983187431661100.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221219081008.1399166-1-u.kleine-koenig@pengutronix.de>
References: <20221219081008.1399166-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 19 Dec 2022 09:10:08 +0100, Uwe Kleine-König wrote:
> lp3943 is a platform driver that doesn't use any symbol provided in
> <linux/i2c.h>. So drop the include.
> 
> 

Applied, thanks!

[1/1] pwm: lp3943: Drop unused i2c include
      commit: 2781f8e9203685208c9f3717593601d4b4674372

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
