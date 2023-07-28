Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00A766596
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjG1HoZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjG1HoY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:44:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC7B6
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcc0adab4so258980466b.2
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690530262; x=1691135062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoBW4j4mPIdPVip7j8ncUxipZYGJJXtzm9JCwdw/Hss=;
        b=BCRmqyO24Rl/811vNwmx28BarXJ6gNMwl1iNFZ5pWYtXXHIV6FnvaQYQIiI36Rzotk
         BUNgN0R6ZBDNVFaJSfcN9Uyw31U99nTvLs6/q5cqZ+Ow/0D8VwfmiD/2evgdeqSWqsfD
         Lva6k/0zKXk4a5xrPOR41UEanWYeXwU1PtJJztrqWwJV9jlSkqQfKp9pm7NUX4KdRN3/
         QY0Cz/xp5cNt3jPewiGRrpxjrUA6Y6oELD6V4qm4kAJwKH7V/is24y+rzmhhNLd7ThTi
         DZVQa04dMiXARX4MMT0wwS+FllnEX7V+UCgpf40lvNXwhCkVQlAmmdXeYXFAyMUdbzQZ
         Fz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530262; x=1691135062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoBW4j4mPIdPVip7j8ncUxipZYGJJXtzm9JCwdw/Hss=;
        b=El4pmDY59ZcqPuLxAXTfHSlzF4bAR9RoXTbFFOG8z0PQ/ogk1zaqOtOy1zqbnM2Kvn
         7GF5fx5RS8SmbyZ6dHRFEyJc2ZpGMMffNbl6656G4D8MdraAzQznL2GcioJLbUd6eCv3
         Wuw5SN/KwLyC1Lqz3pJOsVxgWYbuOyZwv9/PVpcGb/js7RVi//OSCe73I48PPdVg9OqV
         yzg2hOC761IDvEz9Gb2krhjOmuZJy5RqZC1aXKp79oHVmwe6cN8EOsTPsZHDIcmJsbKJ
         1RDRCRYcemseIGnmUh7wdUc/fddVc6NAGRBz89dqZpDoLkoq9xGCpm1Yc/YBaMditQpJ
         Bc9Q==
X-Gm-Message-State: ABy/qLbOxSHHf+s0nSHKeI0/5I6OPMYIZcA+0XHFhvK4p4EME+ZMcvwZ
        m910z9k+KGPH0iKNLssPxEY=
X-Google-Smtp-Source: APBJJlG+vDvdmLrAzqm/SX/MdiUXoysY+2xHhbosT7vwrOcmhVaVyzQQsvC7yTVz+eTmS9lOnbGXPA==
X-Received: by 2002:a17:906:7a5e:b0:993:ec93:a5ef with SMTP id i30-20020a1709067a5e00b00993ec93a5efmr1313085ejo.47.1690530261832;
        Fri, 28 Jul 2023 00:44:21 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gl13-20020a170906e0cd00b00982d0563b11sm1707445ejb.197.2023.07.28.00.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:44:21 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: ntxec: Drop a write-only variable from driver data
Date:   Fri, 28 Jul 2023 09:44:15 +0200
Message-ID: <169053024118.3514419.14544397706500001742.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718152327.2583886-1-u.kleine-koenig@pengutronix.de>
References: <20230718152327.2583886-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Tue, 18 Jul 2023 17:23:27 +0200, Uwe Kleine-König wrote:
> .dev is assigned in .probe() and never read. So it serves no purpose and
> can be removed.
> 
> 

Applied, thanks!

[1/1] pwm: ntxec: Drop a write-only variable from driver data
      commit: 250b4ca0c9d611c61e12a8eb2d24e69f9058de2b

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
