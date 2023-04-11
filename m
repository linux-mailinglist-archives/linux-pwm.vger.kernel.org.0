Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ABD6DD1B1
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDKFe2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 01:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDKFe0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 01:34:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409F271B
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 22:34:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q29so6117013wrc.3
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191263; x=1683783263;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxQ46jzEdPowu1sW0dqP37HDXhAXduI2aAPLIfJFVCM=;
        b=SsftqwyynLZKM1seZzIV5+Uan84LrZOZmacd+BU1uiiOsImQgIux8Z4ypZYxUNCAh4
         NWwDt1DUbEa7k/63DvehaadN8uhwR8b7faXUGq232GPZPzJ/aXfuiNxQJA33TtRed9TP
         Oxibd9uEOJwKj2pm15UkTEOSC1tQ6Ssz+843ALXQkwFC/6H/hjmnVi02RmiW7Cn5M2/y
         jCe9efcumCn5Fg7T7usHGj2OCsccBcDkbXeIgAclxeAHwsRhQJm9ajHavhxIrUscZqaY
         U1vXHbnYiSo8u+95hH+lM0E3Ehh3MoRRE1pWMu6BXfPeOemUJf3RPX1zTdkbuPUxXr9H
         zmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191263; x=1683783263;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kxQ46jzEdPowu1sW0dqP37HDXhAXduI2aAPLIfJFVCM=;
        b=sENXVKFhS5fLUDuutQhAkHybCXXa5PqGBrRVpIq93iM0nvQwtBVmjuSsZcBYZvbwkh
         odTUgTfq6M6t9jDDQriD6rxdFhrNHAq4xqc5SGrzE+rPoA9oNmdUuZstmqwgoByJErOz
         JabQ/OyJ40WfPFdfpGIACAfkY6RL2EzDsyua7ijiKX5oZLrjeXbnsJks64f/zA8b+fez
         Hdb498R9ojI5OmRq0cwlT28KRjjl7n7jYegZFIjgCW0onj7Pz7eQzHJegsvNvqaE1BMw
         W6bX7pm2Sv4p/e8EW6D5ZucPnSGMOJCUK02Z3Z23I2IbQf5HiQgSaB8HK1lz2TaYKufo
         2FIQ==
X-Gm-Message-State: AAQBX9f4hRlwyrBjNmM7CtnCR8iKrDiGqBkjuAd+MaCM4AJ3h17EEK/v
        yxOw/mRaZeWU0Nk1Sg8g7QE=
X-Google-Smtp-Source: AKy350YoZWOjcqGBvUIV6u024td8TbY5wv1bKS3oQHDEk8qVLXhvE/KNKtssWUyxigBMQX8NALgD5g==
X-Received: by 2002:adf:dc92:0:b0:2ca:2794:87e8 with SMTP id r18-20020adfdc92000000b002ca279487e8mr8037932wrj.21.1681191263476;
        Mon, 10 Apr 2023 22:34:23 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:491f:994c:df34:b485? (dynamic-2a01-0c23-c4bb-c200-491f-994c-df34-b485.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:491f:994c:df34:b485])
        by smtp.googlemail.com with ESMTPSA id h16-20020a5d5490000000b002c8476dde7asm13471923wrv.114.2023.04.10.22.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:34:22 -0700 (PDT)
Message-ID: <b53af028-28df-105a-eb50-21a1ed4e15b5@gmail.com>
Date:   Tue, 11 Apr 2023 07:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] pwm: meson: fix g12a ao clk81 name
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fix the name of the aoclk81 clock. Apparently name aoclk81 as used by
the vendor driver was changed when mainlining the g12a clock driver.

Fixes: f41efceb46e6 ("pwm: meson: Add clock source configuration for Meson G12A")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 0fe0400c2..429f6ef4c 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -390,7 +390,7 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 };
 
 static const char * const pwm_g12a_ao_ab_parent_names[] = {
-	"xtal", "aoclk81", "fclk_div4", "fclk_div5"
+	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
@@ -399,7 +399,7 @@ static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 };
 
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "aoclk81",
+	"xtal", "g12a_ao_clk81",
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
-- 
2.40.0

