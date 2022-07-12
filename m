Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE957165C
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 12:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiGLKBU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiGLKBT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 06:01:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251F2B63D
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:01:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so10417971wrx.12
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/OZ12grJH2HGfQQ0JrIOuWpQ+l/DZyZzBE/Hw/nsTI=;
        b=EU7iMlqi8FpeejO7+rMoGD4Wxye2Cox8MctsGtKr3VaNp9WvOjacpSBgkbhWQhphMd
         Jp+D6Gnma3tnEYiiQbeFWAltneO1Gv5ZW/4B+6DkidZcjKMe+g1mqLUIE0U65Xe3qpOW
         Ax/gP6GnCr99NXgsejRbMRk/wh7qvVsviEGfsGxuwDi5JJ9cwLXuCF2YZFdVL1fp8rew
         FXAp4AHMesXA8tUzbpl05D3/Z8WgUSBZOvSqt1TbLKZKYbFSJO5/gqHqlr2YqmbxV3nJ
         UHe6DbLI+jWZtj25qKBDN16kHTlw7bUhDIeWm1E8K1I6IkFI92B7ox5Omkf99OOlRTWZ
         sgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/OZ12grJH2HGfQQ0JrIOuWpQ+l/DZyZzBE/Hw/nsTI=;
        b=F0Wg4uFYgJ22ixf1WFh0T+ZsrCCvO4zaLiyemoDJfaaXeHepEQN/6i0ZeX9SMGK/FL
         oiGU1DqUl808SK6lYTnXHjbORblG0r2AYxAv5PfoGpFP9ZVeHVb4VKgEjbaNRGZsl83M
         vLHRYd9Ck0pk6ptgfXjOxQe5nhiVr1jVlGFa7jD0ONZ0KR3vrawn6WoEJh96VRzo34Jq
         sMhtgH5CJSJdno9IvIBcCds5XB1HTRmQaxg+L8gR6gDpGmr9EZOikKEVQGa4ka1Rdll6
         dYO3Jx/IATR8Z6Cu8yWbRSsTq5wpReLKaRZzeBHSURNfynpabl7qYXijS4cAjla873Pm
         C0Fg==
X-Gm-Message-State: AJIora+1yCNks4T8JJKzXnRvoMLOgd9oFJLswC9D5pLk8PSMQ1jHoTLH
        EPARcBO29jeQxXpOJdsBFY+SC0fMac5s3ear
X-Google-Smtp-Source: AGRyM1sIzjo8aPQG1VOThm59M5Kb+jFhuDRcT8GZoOZVqneIRfH8hw3EuPTOOyTsM10btGdQRShb5A==
X-Received: by 2002:a5d:4d4e:0:b0:21d:7a79:e04c with SMTP id a14-20020a5d4d4e000000b0021d7a79e04cmr21430181wru.519.1657620076357;
        Tue, 12 Jul 2022 03:01:16 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b0039747cf8354sm8895314wmc.39.2022.07.12.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:01:15 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
Subject: update synopsys driver for platform/devicetree support
Date:   Tue, 12 Jul 2022 11:01:06 +0100
Message-Id: <20220712100113.569042-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a series to allow the Synopsys PWM driver to be built for
device-tree/platform usage.

An open question is whether there should be some form of standard
property for the number of PWMs that each device supports.

Note, the patches 5 and 6 could be grouped together as patch
6 undoes some of the bits in 5 for configuration of clock rate.


