Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190A46CB849
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1HhZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjC1HhK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 03:37:10 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE584494
        for <linux-pwm@vger.kernel.org>; Tue, 28 Mar 2023 00:36:47 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id f17so8275638oiw.10
        for <linux-pwm@vger.kernel.org>; Tue, 28 Mar 2023 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679989005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zUPDzhqQG7pVvsZWPkDA6f8B20sI5Wp396ymMcTIkLg=;
        b=lA38ISur2sk+i2ytmwmAFk7aCGvmrsfr0zfUlZvLavkG24ElYJfhD+1nbsyJP5zuHC
         9vHEEbe3Gegm1MvCYrMQrIwmbwHt1kbeb4LuCWY7rMCtL6vwurqFdPcTcw1pGFzRx2VH
         H+acm1yk1h8gkbR/KmKHH7e9P/BLpjK7Mb1BFFl8ab2+W5phSmy7OLfjShpZk2NAcxyQ
         BKRRm6JsqPVpbkYP1tPUtJW19pSXUUNBA3qQ5Sc1brtSDGF4aswmSIt88xPTRzMFMBO8
         /dA2WdETM5ziAZaxobs6LPVy0qDfFEcbuzb5KG2SI+jSByWMBj0pjGN5Cu93E3m8lVBW
         p6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUPDzhqQG7pVvsZWPkDA6f8B20sI5Wp396ymMcTIkLg=;
        b=At3opl4BOuau/A4oDbpHu7vV7x7ZyCkiWa+wpQ2hHRPfA7vLdhWMTgKNVcY0gcTStY
         nNrjC++yxqHsk9wF8OSLnvdlHfk6kSpw3ulz/cYbehdoaUkXiJI2DtbfC18oEH87uNLE
         CcdAp6ifa57UC7osME//3aCZAlBDvZ+f2ipVohwRw+12F16LhT8GD35H0sZFlKPQhgzR
         9aAoiTy2GATIPAJTdRULR9vUCqUJ6Zqn7FyhUn0qyOjcGBLgpr4df+195wVOIZQup874
         tIowDiq/rNoqPWxWZionBVWxjMQGgagtnxLRQT/GqJYZoR+c55h0SFYrDrMtYNAnPkGE
         uHuw==
X-Gm-Message-State: AAQBX9esROcX7Aw3mur1DYtChqmmTIM/Y5xHSY0JkFEbxG/fr1MV4AgQ
        mJbT7NIG1HPPjrEcLpVrn2Tc3TEFW0kQCnQ6AJtn+tNy4zE=
X-Google-Smtp-Source: AKy350YQ4jYc3a/wowc/TFF8nNvaFF+s3UUsqIhbmKwFpXetTRayjjRsHxb20ONneKJrvLWkkDw0ZqiVzoMt09It5dY=
X-Received: by 2002:aca:1a02:0:b0:389:50f2:4ab6 with SMTP id
 a2-20020aca1a02000000b0038950f24ab6mr685373oia.1.1679989005199; Tue, 28 Mar
 2023 00:36:45 -0700 (PDT)
MIME-Version: 1.0
From:   Ann Zhou <annzhou99@gmail.com>
Date:   Tue, 28 Mar 2023 15:35:00 +0800
Message-ID: <CAB=gZe8Htg2OZH_c3sawDtB7E=cfyR-PRS=y4rSUfW_UU_LD7w@mail.gmail.com>
Subject: electronic components
To:     linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hey guy=EF=BC=8C
Have a nice day.

We are a professional electronic components vendor in Shenzhen, China.

If you are interested in=EF=BC=8Cwelcome to make an inquiry.

Looking forward to working with you.

________________________________
Best regards!
Ann Zhou
GOSON TECHNOLOGY (HONGKONG) LIMITED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Add: Rm B313, Building B, Changan Zhigu,  Shajiang Road No. 199,
Songgang Street,
         Bao 'an District, Shenzhen China
Phone / Wechat / What's App : +86 18894784132
Website:https://www.gosonxm.com
E-mail : sales01@gosonxm.com
