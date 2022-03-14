Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24C64D7FAB
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Mar 2022 11:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiCNKTS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Mar 2022 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbiCNKTR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Mar 2022 06:19:17 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567D2409B
        for <linux-pwm@vger.kernel.org>; Mon, 14 Mar 2022 03:18:07 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-2d07ae0b1c4so156324587b3.11
        for <linux-pwm@vger.kernel.org>; Mon, 14 Mar 2022 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=QLLsRy/dmyqoI0RxbutlRZI/KB6PQe9IvOCU+8CAeBQGMyqmF6/tAgeCdcEdZZWTQR
         +lM4dx52NBCcTyQ2m0WfXEwW0vNy/Q2h5+2c+HanumuiwHWZmSKPKFlw44pXKTJtml+R
         dwkeF3hAq1OG1XPpJqiioazUaaQX+JYj0dZPXjKsK11KQt1mm6NBeApJvW01vlTwCTmr
         0zavqxu3N8bMBLwVdJob1TzN3h9Ad2e2PR9EIiqawtuU/tja8f0QInngMnTjQrwOBH97
         yAIfAPxmHT/edHFTmHy/X6VQzKIXHrAJ5+snD7BUcPM2WrhmxfSgG3hq1NGxgIWRcIi2
         0/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=k/pk3lDcbh0uQPXoWkKjj689fq4tCZec3XCDa81HlUsKWGDQYWoOaZdt16ycKzX4RJ
         iEY9pYrqmbumqMC/6TCyCerD+JiKyb81BCy54juOuI1iipOyT2xDhu53kLVe/jFnRwXB
         ai2UVV/hZXa/LTMuC9kSD8jwmqKFFLE7zFxGsXosAR4Xsx+IdbDNecO9i2OXOHyVy//+
         Vsv6q5Nw6wWNSfrVcRdsjNKmZKhLvnGylM0N0dlFUl4U9a/h15rYAp42YX6AVuWD1dWY
         tYbICNqp6xqsRi9lLQKM4SQLhD2Fy7lDY9cHNAz5lUElymZy54hyS+POV/K/njd3iBCK
         Ibow==
X-Gm-Message-State: AOAM530u1tz+fWvFDfqAGmwS/eeOcszs22ey3OhTynSz7cyx/YvF2M9g
        YqmtfFzu1nn0kv08e1lj4a3ipexh0uUwWAdokeI=
X-Google-Smtp-Source: ABdhPJxt3sbAxxrwf4Yfrv8UBK0gVaHR239NIWyNSkIxk2Sc5EP6VOe5GgMUyXsnR38oFmRN2oH1ymMI9cBZdKCj6G0=
X-Received: by 2002:a81:738a:0:b0:2dc:2bf4:76b0 with SMTP id
 o132-20020a81738a000000b002dc2bf476b0mr17333592ywc.296.1647253085893; Mon, 14
 Mar 2022 03:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:664e:0:0:0:0 with HTTP; Mon, 14 Mar 2022 03:18:05
 -0700 (PDT)
Reply-To: lawrencetansanco.y@gmail.com
From:   Lawrence Tansanco Yacouba <ltansancoy@gmail.com>
Date:   Mon, 14 Mar 2022 10:18:05 +0000
Message-ID: <CAK5Y89B_nM=NB3F74FU=OkW46S8+sqUpfZMbv5ei+DSF9F90LA@mail.gmail.com>
Subject: THANKS FOR YOUR RESPONSE AND GOD BLESS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.
I will like to disclose something very important to you,
get back for more details please.

Regards.
Mr Lawrence Tansanco Y.
