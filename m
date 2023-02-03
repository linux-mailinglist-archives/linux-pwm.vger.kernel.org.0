Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07578689C52
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Feb 2023 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjBCO4Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Feb 2023 09:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjBCO4T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Feb 2023 09:56:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7859F9F7
        for <linux-pwm@vger.kernel.org>; Fri,  3 Feb 2023 06:56:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r2so4876098wrv.7
        for <linux-pwm@vger.kernel.org>; Fri, 03 Feb 2023 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GE8LRefBbCr+vfDK+OAPRXSUgs+NOR142JeKY5u24zc=;
        b=lQ+Bfh6OkWkCBU99Jb4AoJvJIG7HKtjAaLqAEaz2ki2xFEV18ywmHNcz5VmpBDmjmJ
         SXtSu30qXHHM+Udai2mJHBuBUC7LChxZMBrDiJXjE99Li5JAznexcjJX449U96AFIssl
         jThvEaitV1aiToqDuEiKLWc1n1+h1/JdtRq/ie3dNJF3DbTX9ycYSzLaNnpAaU49/Ftx
         pZBkJQgONJawVE3PgRv1N5Wz9xxO4VeLm0JEbus+Ir+YzE42tl4pgeEAJh2tEj+cR6N5
         /x/FRUtqP9cUFaBVwIa3I5zkSbNXH7ovXJ5dJ988FbHmoKLCkWmjQhGP0rCl6+biA9aV
         gaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GE8LRefBbCr+vfDK+OAPRXSUgs+NOR142JeKY5u24zc=;
        b=voGl5MaheOwgXCF1FfYy4PfK9xUrKsB96rfytV/2G3kBeFE84vQH+56SlCOMBaTmRQ
         wl1yWHN5Ss1mp46yW9POEf6u6v7NcTrx7XY+i+xYQmYDl6udTUvIvIqe2Q0p20eEWhne
         +9pVx0s3lOP5bK46Fvha5AdGmDDiyE7LhyPdsHVnUphCqg0iogfvWruoiYJv4ufWTTUX
         8duRkg0d8L/rt8nzZS5oFVJgrYBis7pO+Ovsm9yGhGBkaeJioTMz2PBmmgWAhSJn/Yj0
         srfVdYN83StwwaxbxsNP3LHqm3TE6jRqH2oG1fPEXfkKpzHxDYqcOb0/MeYci6kT2Arv
         +GYQ==
X-Gm-Message-State: AO0yUKUEVah2Zy0uISD9bxUof/qJoPpIV8oK76bf/251B7/sBZk6B2uu
        BHtD4GhiDC+eNP4QKXdDCEZiRCFuPvlWsp5SkpM=
X-Google-Smtp-Source: AK7set/hydzP0dXLoWgVSTnW+bbYDLJg0Zp3X0fwDhpfSHGwr5RZxb4gFuIIBVQQ1gks/JrOIf9JxjGcoq9+9rZXulo=
X-Received: by 2002:a5d:6481:0:b0:2bf:b373:149a with SMTP id
 o1-20020a5d6481000000b002bfb373149amr397802wri.355.1675436172859; Fri, 03 Feb
 2023 06:56:12 -0800 (PST)
MIME-Version: 1.0
Sender: dareadja5@gmail.com
Received: by 2002:a05:6020:4710:b0:259:ad88:21bb with HTTP; Fri, 3 Feb 2023
 06:56:12 -0800 (PST)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Fri, 3 Feb 2023 14:56:12 +0000
X-Google-Sender-Auth: XsYMg48CSVVgdrD4EWG4jSd7Jsw
Message-ID: <CAE9bZtNJU58hibyfSYAcMuTSc1B_Qq0rag54mPxZC9pGq_MD8g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dia duit a st=C3=B3r, an bhfuair t=C3=BA mo theachtaireacht roimhe seo?, Go
raibh maith agat.
