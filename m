Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0870E7E1722
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Nov 2023 23:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjKEWAP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Nov 2023 17:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjKEWAO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 5 Nov 2023 17:00:14 -0500
X-Greylist: delayed 5179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:00:11 PST
Received: from SMTP-HCRC-200.brggroup.vn (unknown [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321CD9
        for <linux-pwm@vger.kernel.org>; Sun,  5 Nov 2023 14:00:10 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 391FD197B6;
        Mon,  6 Nov 2023 01:58:12 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 32A87195E6;
        Mon,  6 Nov 2023 01:58:12 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id C4E861B824EE;
        Mon,  6 Nov 2023 01:58:13 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ID_MLmaB3PJG; Mon,  6 Nov 2023 01:58:13 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 944CF1B8250F;
        Mon,  6 Nov 2023 01:58:13 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 944CF1B8250F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210693;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=uHgYc7uW8mvwtKFJ67uQGGZhAXjJdfQz/2OwXoRFu7GHaDl83YINDqOUVjsZfcPqn
         6D6lcsUeY0TEK+vF9vQVlr15hkEJUfEr9f+Z+B//MP5YTfsURvJEksxRXqa+CeNRA6
         xhcxIbI5lUEgTrr4QdSKuhbRKBn7N70Zaux8FxzfWwnz9B31wJVMIHANSSz0Sma9Oe
         Wh07GYK3dCuMhlDdla5yENHQfvjmFLyQXGNcri+OEZC+RenKT3lJUhjITFt9CgaVBx
         kzLhj7ESY5QpBxed1wiaIuLnZLhxiMZL7MEkdEtK7FiklL4v5zlXpHfFXuNBOR+569
         r3u/GnrEcqlIQ==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EUDrd0LxXRmc; Mon,  6 Nov 2023 01:58:13 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 0E0061B824EE;
        Mon,  6 Nov 2023 01:58:06 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:56 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185807.0E0061B824EE@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

