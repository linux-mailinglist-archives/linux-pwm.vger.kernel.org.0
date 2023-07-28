Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6F766597
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjG1Ho0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjG1HoZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:44:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0BF2D60
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992e22c09edso242879166b.2
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690530263; x=1691135063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd83Jh/3H6SXfOO6X9CfgkMq+yreUk1EP4R59aUIljw=;
        b=D75vlMS7/NxG0QGnaa0/hRwItobDsDeF9CJqvG7t7bEeNK9I8gRDXchsfPYKPH7yj0
         V6Qcw2DEOxk57JOPheAKZBfR5qlokUovdD1DpZHHabPesO7uGxu3LOCRGIB5AyzFrkFS
         FgPqpLZm/F/Nt1PV9EjTXg0voNzuClBtZkDiU566QV59E0EN1s4RsrujNwj+PKmcbkml
         X/lT9UkyzIFyCXsD+o5FxIawgdxasplik3uNWY1I6II4rO0flEdOd7T0vTko01V62B9y
         U24HZ/EPIXOUI4lNdUZT6vWestgDbIOgh8/caz79M4GVnsTpS83OtTqhcXfty6GTUp4/
         7iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530263; x=1691135063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd83Jh/3H6SXfOO6X9CfgkMq+yreUk1EP4R59aUIljw=;
        b=d27uhbKeeI4e+nm8jWnX2enTAjJGTuzN/v/fPR9gi8HNQf24kylcLjPJ+aoEvvcMgH
         FP0f99UjfWtwwc+kkv5oqjv9QF2kDIqOjBoSLvfLUVBCtFqqFdG0EDofB8oFMphYVjZn
         t7SLQlaSDS9WBmTpScP0kO8X9pbaqcReqnujMuT0FmMQZI8OipW6lHly0mpuLMMP1BR6
         TzzPzTuCRDESEog+zu811Qjc9XwffWjda4yVpEpoB9XxghF3ePcxuJ4StWc0gTry5SIg
         F6CJWBQzVrQyoivso+7EovVAmOhlSKXw6GcxsEoQtWiom+1L2wmTYuvuabS9I1d0zi46
         nuLA==
X-Gm-Message-State: ABy/qLa7FEcIxX3FiePgsZYgiRLzu4P6j5MH9voybcSjpN/8PO4oFvWH
        goO/2w5f2ys6w9S0KrkKz7M=
X-Google-Smtp-Source: APBJJlFW+4RrMYkM0nLOqlfo3lE+LjeoZLvb1Ljibv9KmBVakuav54v5k7nrB9IXBG6M6v0iQlrNrQ==
X-Received: by 2002:a17:906:77cd:b0:99b:d178:f051 with SMTP id m13-20020a17090677cd00b0099bd178f051mr1489962ejn.64.1690530262813;
        Fri, 28 Jul 2023 00:44:22 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id mf25-20020a170906cb9900b0099251a40184sm1727846ejb.99.2023.07.28.00.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:44:22 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] pwm: ntxec: Use device_set_of_node_from_dev()
Date:   Fri, 28 Jul 2023 09:44:16 +0200
Message-ID: <169053024119.3514419.4968147745236278388.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718175310.3946687-1-u.kleine-koenig@pengutronix.de>
References: <20230718175310.3946687-1-u.kleine-koenig@pengutronix.de>
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


On Tue, 18 Jul 2023 19:53:10 +0200, Uwe Kleine-König wrote:
> Compared to overwriting pdev->dev.of_node directly, this takes care of
> reference counting. It also prevents that the parent device matches this
> driver. See commit 9b22c17a3cc5 ("of: Check 'of_node_reused' flag on
> of_match_device()") for further details.
> 
> 

Applied, thanks!

[1/1] pwm: ntxec: Use device_set_of_node_from_dev()
      commit: 387c74e5f91d8e6f0c6e49fddd8b0e53118e5def

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
