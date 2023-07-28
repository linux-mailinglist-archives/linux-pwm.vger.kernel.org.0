Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7D76655F
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjG1HbI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjG1HbG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:31:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC22728;
        Fri, 28 Jul 2023 00:31:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99454855de1so240321866b.2;
        Fri, 28 Jul 2023 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690529464; x=1691134264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFaMKzaM38EwIrtZmz3qhYzztZrvQsEU1lTjN4MApUc=;
        b=bUOMc9gQZmrZpWF5Lb7Tn5mLgPQPNGQwr4z27vKuOSbXddvcJxvCCTp8gJ2TO1ah5L
         AW4H4oy9UY7SskleUWfDdZxT8iqWzv9iAl0iZXKG2JRUwo+0IjFpoMdEm0u/VkbePFiY
         hlRqVuX44fEDqxcgrQrCpadY7r7bJze1oJBgzC9WRNzvP3B0XoHCRGGVQJJqLS5baWF0
         n+NyKl41Ha9yv8d4ymJuBZXETZpVL0dGJrUAm1QHIu8cIus82MIg+DKhkSIK6lGs9aCK
         IGBXaVRRygKDKCQF7+0A/57ZvPwvefhuRcAZtAZxbe+hSPnz4skzv3D6IA4oWmJQvBTm
         5EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529464; x=1691134264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFaMKzaM38EwIrtZmz3qhYzztZrvQsEU1lTjN4MApUc=;
        b=VMHr3Uu+gxqQ3EAE97eqcKKYbM14YLwcCHa/MWu0Sjsz9QSjEgNVdx7Y+CPj3r/Fb8
         s81nwNDm/TeRG0RFLCj1QVSa5mgacOWp/rKQBU2Yu1XFrTenuyMmbzQljkz86wPH7xr+
         /OPTdLsGfVI2fRKWYYJA3QNzpsKsAwSoGxwnmET312UHJT/xec/k7cZsO1lO4BjtrUUN
         5uDLSvZnQcFj85cRAJ12KVHF9955z/H7jz1vZ7DVqFGAe6AX/uwToOELigRUtc3q3kz6
         xS2kaSiijYLvOiy/tbVbymhwSOOKdMAXIZEbVKOZVbB5HhBUiva2wSUDYmSEhjdJN/+g
         qgkg==
X-Gm-Message-State: ABy/qLZ7N+iSwD8geIjD3EytHo19q399jCp8h8RM3i+O0Zo7G4Ldn0CM
        LnVB8pBvRoUG/MIfNuQwX9o=
X-Google-Smtp-Source: APBJJlFnIS6gg6OHXQKb9YoOntwrFo14c4Sljtmuxwi0mzgtQcGgUTg9rcu4DOoeWZWCxX4jrEbJZA==
X-Received: by 2002:a17:907:7759:b0:99b:c949:5ef9 with SMTP id kx25-20020a170907775900b0099bc9495ef9mr1308608ejc.11.1690529463543;
        Fri, 28 Jul 2023 00:31:03 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id si15-20020a170906cecf00b00992e265495csm1732004ejb.212.2023.07.28.00.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:31:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described
Date:   Fri, 28 Jul 2023 09:31:00 +0200
Message-ID: <169052945393.3512110.17989354046392764890.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725135921.125765-1-biju.das.jz@bp.renesas.com>
References: <20230725135921.125765-1-biju.das.jz@bp.renesas.com>
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


On Tue, 25 Jul 2023 14:59:21 +0100, Biju Das wrote:
> Fix the below build warning:
> warning: Function parameter or member 'num_channel_ios' not described
> in 'rz_mtu3_channel_io_map'
> 
> 

Applied, thanks!

[1/1] pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described
      commit: bdebe27e3dc22c11c72b0d1ef4ed30355f154e58

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
