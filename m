Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2BE61FC7C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 19:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKGSC1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 13:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiKGSBy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 13:01:54 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA927142;
        Mon,  7 Nov 2022 09:57:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id k2so32314878ejr.2;
        Mon, 07 Nov 2022 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxMGJzI9yczq35UtPAYAALllIJzZbRyIRY5qsOAYDYM=;
        b=cp8fQ/lr2pACh25o4SFAe29CEOBwkgD5CiYwkbnVPImCgnC7svPfyzyrbNN7CI4c5y
         Sq+x/D7OV1wgNJprVeXLtksMAe8//y1t78qEMuuE+duZgYjKtw2yU9PAHKoz2LvisRXn
         o5YKvxaG0kG6POCXMM38s0UKyCxA1TAV9mkqAkp8xjmLsSe6wIdDlwhZyww57aPKaDW3
         d3TpSAGZtMgJVO3WNJIA1GsUzC+O2s5F7FzlFF7EmH0k77NAFzRuEi19WXMJ7Dfo1zzN
         42URxYQCjhED0S8sErvQfqQsLZsPmtoieNSiZt/1JkOMA4QMQo/IpX2vaBtIBNdn/BOH
         NSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxMGJzI9yczq35UtPAYAALllIJzZbRyIRY5qsOAYDYM=;
        b=5Zhs2mB1vTKxVyOeG146aWP+Z1W0knDwYBtQGfc4v4DO6DdaxbC1NbXAuLGsac8XHe
         xKHHLCae2/LdDOfLc5dh8C36vHdgaqQY8V//KXE2Qto68IuPmIJWNx8zbE0ErX3Bv27V
         K1dpMyL+cuGtw+YNqITyhD7h0ZTFztsDrmzKGRIRDo5NxtNjs8+bR1BNr/z+2Ax/EFgY
         0ZPz5xBiKLbXk3hFnrl0TuR8Isrhv/zLHhAnlAtjqoYaJNxOAMBhg5Tz/mmdmTuA79Z7
         pJeEo5lyPD6zmUQ9dwnInDIorPzxARUMJ3nWXz5Kuh+qGYmhtaLUcnJYJ/FJM29AsieC
         0hbw==
X-Gm-Message-State: ACrzQf3Zy68dkDEO5sQsPsYEFCEzHtJaHWqj6GJL4QaOy8TCJBav+11X
        Ta8N4u+VkshBY+n0dil4BN4=
X-Google-Smtp-Source: AMsMyM60zRpbHPqPHVqmb2QTP+YCYUc0O09jY92wMfgdidMGGiCojPWPfJezpn4zPnFACI1XXhcE7Q==
X-Received: by 2002:a17:906:cc0f:b0:7ad:2da5:4711 with SMTP id ml15-20020a170906cc0f00b007ad2da54711mr48408500ejb.628.1667843864825;
        Mon, 07 Nov 2022 09:57:44 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7cb92000000b00458947539desm4563899edt.78.2022.11.07.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:57:44 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 02/10] ARM: dts: suniv: f1c100s: add PWM node
Date:   Mon, 07 Nov 2022 18:57:43 +0100
Message-ID: <2201604.iZASKD2KPV@kista>
In-Reply-To: <20221107005433.11079-3-andre.przywara@arm.com>
References: <20221107005433.11079-1-andre.przywara@arm.com> <20221107005433.11079-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne ponedeljek, 07. november 2022 ob 01:54:25 CET je Andre Przywara 
napisal(a):
> The Allwinner F1C100s family of SoCs contain a PWM controller compatible
> to the one used in the A20 chip.
> Add the DT node so that any users can simply enable it in their board
> DT.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


